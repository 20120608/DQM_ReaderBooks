//
//  DQMReaderPageViewController.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMReaderPageViewController.h"
#import "Toast.h"
#import "DQMReaderContentViewController.h"            //contentView 用于显示文字信息
#import "DQMPageTopView.h"                            //返回界面
#import "DQMPageBottomView.h"                         //控制界面
#import "DQMPageDirectoryView.h"                      //目录
#import "DQMReadingHistoryFMDBManager.h"              //记录阅读的历史记录FMDB管理类


@interface DQMReaderPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,DCPageBottomViewDelegate,DCPageTopViewDelegate,DCBookListViewDelgate,UIGestureRecognizerDelegate>
{
  CGSize _contentSize;
}

@property (nonatomic,strong ) UIPageViewController           *pageViewController;//控制分页的控件
@property (nonatomic,strong ) DQMPageTopView                 *topView;//导航栏
@property (nonatomic,strong ) DQMPageBottomView              *bottomView;//底部菜单
@property (nonatomic,strong ) DQMPageDirectoryView           *listView;//目录视图

@property (nonatomic,strong ) NSDictionary                   *attributeDict;//文字属性(最好用苹果方以免出现u不必要的BUG)
@property (nonatomic,assign, getter = istoolViewShow) BOOL   toolViewShow;//是否显示工具栏
@property (nonatomic,assign ) NSInteger                      currentIndex;//当前第几页
@property (nonatomic,assign ) NSInteger                      currentChapter;//当前第几章章
@property (nonatomic,strong ) NSArray                        *list;//目录
@property (nonatomic,strong ) NSArray                        *chapterArr;//拆分成章节的数组
@property (nonatomic,strong ) DQMReaderContentViewController *currentVC;//显示的文字视图控制器
@property (nonatomic,strong ) NSArray<NSMutableAttributedString *> *pageContentArray;//每一章 分页的数组
@property (nonatomic,copy   ) NSString                       *textFontSize;//字体大小


@end

@implementation DQMReaderPageViewController

#pragma mark  - life cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  //初始化
  [self initialization];
  //加载数据
  [self loadData];
  
  //添加UI
  DQMReaderContentViewController *contantVC = [self viewControllerAtIndex:_currentIndex];
  [self.pageViewController setViewControllers:@[contantVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
  self.pageViewController.view.frame = self.view.bounds;
  [self addChildViewController:self.pageViewController];
  [self.view addSubview:self.pageViewController.view];
  [self.view addSubview:self.topView];
  [self.view addSubview:self.bottomView];
  [self.view addSubview:self.listView];
  
  //添加手势
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
  tap.delegate = self;
  tap.numberOfTapsRequired = 1;
  [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated
{
  self.navigationController.navigationBarHidden = YES;
}



#pragma mark - load data    init UI
- (BOOL)prefersStatusBarHidden
{
  return !self.toolViewShow;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}


/**
 初始化
 */
-(void)initialization {
  
  //文字大小 默认20
  self.textFontSize = [[NSUserDefaults standardUserDefaults] objectForKey:DCTextFontSize];
  if(!self.textFontSize)
  {
    self.textFontSize = [NSString stringWithFormat:@"%d",DCDefaultTextFontSize];
    [[NSUserDefaults standardUserDefaults] setObject:self.textFontSize forKey:DCTextFontSize];
  }
  _currentIndex = 0;
  _currentChapter = 0;
  
  
  //取出历史记录
  DQMReadingHistoryFMDBManager *historyDBManager = [DQMReadingHistoryFMDBManager sharedInstance];
  if ([historyDBManager OpenOrCreateReadHistoryFMDB]) {//打开
    //找历史记录
    DQMReadHistory *oldHistoryModel;
    oldHistoryModel = [historyDBManager searchDataToReadHistory:_readHistoryModel];
    if (oldHistoryModel == nil) {
      NSLog(@"没有记录");
      //插入
      DQMReadHistory *newHistoryModel = [[DQMReadHistory alloc] init];
      newHistoryModel.textFontSize = self.textFontSize;
      newHistoryModel.name = _readHistoryModel.name;
      newHistoryModel.path = _readHistoryModel.path;
      newHistoryModel.type = _readHistoryModel.type;
      newHistoryModel.currentChapter = 0;
      newHistoryModel.currentIndex = 0;
      [historyDBManager insertDataToReadHistory:newHistoryModel];
    } else {
      //存在记录
       NSLog(@"有记录 下标 = %ld  章节 = %ld 字体 = %@",oldHistoryModel.currentIndex,oldHistoryModel.currentChapter,oldHistoryModel.textFontSize);
      [[NSUserDefaults standardUserDefaults] setObject:oldHistoryModel.textFontSize forKey:DCTextFontSize];
      //设置数据
      oldHistoryModel.path = _readHistoryModel.path;//少这一步开发时缓存位置会变 会导致取不到字符串而崩溃
      _readHistoryModel = oldHistoryModel;
      self.textFontSize = oldHistoryModel.textFontSize;
      _currentIndex = oldHistoryModel.currentIndex;
      _currentChapter = oldHistoryModel.currentChapter;
      NSLog(@"查询完毕");
    }
  }
  NSLog(@"设置接下去的");
  
  _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:DCDefaultTextFontName size:self.textFontSize.intValue]};
  _contentSize = kContentSize;
  self.toolViewShow = NO;
}


/**
 刷新数据
 */
-(void)loadData
{
  NSString *string;
  if(_readHistoryModel.path) {
    string = [DQMFileTools transcodingWithPath:_readHistoryModel.path];
  }
  self.list = [DQMFileTools getBookListWithText:string];
  self.chapterArr = [DQMFileTools getChapterArrWithString:string];
  self.listView.list = self.list;
  //加载第一章文字
  [self loadChapterContentWithIndex:_currentChapter];
}

/**
 根据章的下标分页
 @param index 第几章
 */
-(void)loadChapterContentWithIndex:(NSInteger )index
{
  NSArray *arr =  [self pagingWithContentString:self.chapterArr[index] contentSize:_contentSize textAttribute:self.attributeDict];
  self.pageContentArray = arr;
}


/**
 根据内容和显示的高度还有富文本样式返回分页数组

 @param contentString 要拆分的文字内容
 @param contentSize 实际显示的区域大小
 @param textAttribute 富文本样式  最好用苹果方
 @return 视图控制器的数组
 */
-(NSArray *)pagingWithContentString:(NSString *)contentString contentSize:(CGSize)contentSize textAttribute:(NSDictionary *)textAttribute {
  NSMutableArray *pageArray = [NSMutableArray array];
  NSMutableAttributedString *orginAttributeString = [[NSMutableAttributedString alloc]initWithString:contentString attributes:textAttribute];
  NSTextStorage *textStorage = [[NSTextStorage alloc]initWithAttributedString:orginAttributeString];
  NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
  [textStorage addLayoutManager:layoutManager];
  int i=0;
  while (YES) {
    i++;
    NSTextContainer *textContainer = [[NSTextContainer alloc]initWithSize:contentSize];
    [layoutManager addTextContainer:textContainer];
    NSRange rang = [layoutManager glyphRangeForTextContainer:textContainer];
    if(rang.length <= 0)
    {
      break;
    }
    NSString *str = [contentString substringWithRange:rang];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str attributes:textAttribute];
    [pageArray addObject:attstr];
  }
  return pageArray;
}


/**
 根据下标 获取显示的视图控制器

 @param index 第几个
 @return 显示的试图控制器
 */
- (DQMReaderContentViewController *)viewControllerAtIndex:(NSUInteger)index {
  if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
    return nil;
  }
  // 创建一个新的控制器类，并且分配给相应的数据
  DQMReaderContentViewController *contentVC = [[DQMReaderContentViewController alloc] init];
  contentVC.content = [self.pageContentArray objectAtIndex:index];
  [contentVC setIndex:index totalPages:self.pageContentArray.count];
  contentVC.currentIndex = index;
  contentVC.currentChapter = _currentChapter;
  self.currentVC = contentVC;
  [self saveUserReadedHistory];//保存记录
  return contentVC;
}


/**
 保存记录
 */
- (void)saveUserReadedHistory {
 
  DQMReadingHistoryFMDBManager *historyDBManager = [DQMReadingHistoryFMDBManager sharedInstance];
    DQMReadHistory *newHistoryModel = [[DQMReadHistory alloc] init];
    newHistoryModel.textFontSize = self.textFontSize;
    newHistoryModel.name = _readHistoryModel.name;
    newHistoryModel.path = _readHistoryModel.path;
    newHistoryModel.type = _readHistoryModel.type;
    newHistoryModel.currentChapter = self.currentVC.currentChapter;
    newHistoryModel.currentIndex = self.currentVC.currentIndex;
    //更新
   BOOL result = [historyDBManager updateDataToReadHistory:newHistoryModel];
    NSLog(@"更新状态:%@",result ? @"成功" : @"失败");
}



#pragma mark  - event

/**
 点击事件显示隐藏工具栏
 */
-(void)tap:(UITapGestureRecognizer *)tap
{
  CGPoint point = [tap locationInView:self.view];
  if(point.x < kScreenWidth * 0.3 || point.x > kScreenWidth * 0.7 || point.y <kScreenHeight * 0.3 || point.y > kScreenHeight * 0.7)
    return;
  if(self.toolViewShow) {
    //显示了则退回去
    [UIView animateWithDuration:0.3 animations:^{
      self.topView.transform = CGAffineTransformIdentity;
      self.bottomView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
      self.topView.hidden = YES;
      self.bottomView.hidden = YES;
    }];
  } else {
    //没显示则显示出来
    self.topView.hidden = NO;
    self.bottomView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
      self.topView.transform = CGAffineTransformMakeTranslation(0, NAVIGATION_BAR_HEIGHT);
      self.bottomView.transform = CGAffineTransformMakeTranslation(0,-TAB_BAR_HEIGHT);
    }];
  }
  self.toolViewShow = !self.toolViewShow;
  //更新状态栏是不是显示
  [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark  - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  // 若为UITableViewCellContentView（就是击了tableViewCell），则不截获Touch事件（就是继续执行Cell的点击方法）
  if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
    return NO;
  }
  return YES;
}
//目录点击事件 跳转到对应章节  历史记录写法类似
-(void)bookListView:(DQMPageDirectoryView *)bookListView didSelectRowAtIndex:(NSInteger)index {
  
  //以当前页作为要跳转的章节页面的首页 并设置值才不会跳转后出现切换页BUG
  self.currentVC.currentIndex = 0;
  self.currentVC.currentChapter = index;
  [self checkCurrentIndexAndCurrentChapter:self.currentVC];
  
  [self loadChapterContentWithIndex:_currentChapter];
  self.currentVC.content = self.pageContentArray[_currentIndex];
  [self saveUserReadedHistory];//保存记录
}

/**
 返回手势
 */
-(void)backInDCPageTopView:(DQMPageTopView *)topView
{
  [self.navigationController popViewControllerAnimated:YES];
}

/**
 目录显示隐藏控制
 */
-(void)listClick:(UIButton *)btn {
  //隐藏了就显示出来
  self.listView.hidden = NO;
  
  //显示了则退回去
  [UIView animateWithDuration:0.3 animations:^{
    self.listView.transform = CGAffineTransformMakeTranslation(kScreenWidth * 0.8, 0);
    //显示了则退回去
    self.topView.transform = CGAffineTransformIdentity;
    self.bottomView.transform = CGAffineTransformIdentity;
  }completion:^(BOOL finished) {
    self.topView.hidden = YES;
    self.bottomView.hidden = YES;
  }];
  self.toolViewShow = NO;
  //更新状态栏是不是显示
  [self setNeedsStatusBarAppearanceUpdate];
}


/**
 白天黑夜切换功能
 */
-(void)readModeClick:(UIButton *)btn
{
  NSArray *arr = self.pageViewController.viewControllers;
  if(arr.count != 1)
    return;
  DQMReaderContentViewController *vc = self.pageViewController.viewControllers.firstObject;
  
  if(btn.selected)
  {
    [[NSUserDefaults standardUserDefaults] setObject:DCReadNightMode forKey:DCReadMode];
  }else
  {
    [[NSUserDefaults standardUserDefaults] setObject:DCReadDefaultMode forKey:DCReadMode];
  }
  //更新UI
  [vc updateUI];
}


/**
 更换字体大小

 @param type DCSetupFontType  加减
 */
-(void)setUpFontClick:(DCSetupFontType)type
{
  int fontSize = self.textFontSize.intValue;
  
  if(type == DCSetupFontTypeAdd)
  {
    //字体变大
    if (fontSize >= 28) {
      [self.view makeToast:@"字体不能再变大了！"];
      return;
    }
    fontSize+=2;
  }else{
    //字体缩小
    if (fontSize <= 8) {
      [self.view makeToast:@"字体不能再变小了！"];
      return;
    }
    fontSize-=2;
  }
  self.textFontSize = [NSString stringWithFormat:@"%d",fontSize];
  _attributeDict = @{NSFontAttributeName:[UIFont fontWithName:DCDefaultTextFontName size:fontSize]};
  
  //存储字体大小
  [[NSUserDefaults standardUserDefaults] setObject:self.textFontSize forKey:DCTextFontSize];
  
  //重新计算分页
  [self loadChapterContentWithIndex:_currentChapter];
  if ([self.pageContentArray count] <= _currentIndex) {
    _currentIndex = [self.pageContentArray count] - 1;//字体变化后页数少了取最后一页
  }
  self.currentVC.content = self.pageContentArray[_currentIndex];

  //设置页数
  NSArray *arr = self.pageViewController.viewControllers;
  if(arr.count != 0) {
    DQMReaderContentViewController *vc = self.pageViewController.viewControllers.firstObject;
    [vc setIndex:_currentIndex totalPages:self.pageContentArray.count];
  }
  
  [self.view makeToast:[NSString stringWithFormat:@"字体大小为: %@",self.textFontSize]];
}


#pragma mark - 上下页的试图控制器代理方法
/**
上一页
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
  
  //设置下标和章节 否则换页会有BUG
  [self checkCurrentIndexAndCurrentChapter:viewController];
  
  if(_currentIndex == 0 && _currentChapter == 0)
  {
    //第一章第一页
    return nil;
  }else if(_currentIndex == 0 && _currentChapter > 0)
  {
    //非第一章第一页，加载上一章的内容,
    _currentChapter--;
    [self loadChapterContentWithIndex:_currentChapter];
    _currentIndex = self.pageContentArray.count - 1;
  }else
  {
    //不是第一页，则页码减一
    _currentIndex--;
  }
  return [self viewControllerAtIndex:_currentIndex];
}

/**
点击或滑动 UIPageViewController 右侧边缘时触发
*  @param pageViewController 翻页控制器
*  @param viewController     当前控制器
*  @return 返回下一个视图控制器
*/
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
  
  //设置下标和章节 否则换页会有BUG
  [self checkCurrentIndexAndCurrentChapter:viewController];

  
  if(_currentIndex >= self.pageContentArray.count && _currentChapter >= self.chapterArr.count)
  {
    //最后一章最后一页
    return nil;
  }else if(_currentIndex >= self.pageContentArray.count - 1 && _currentChapter <self.chapterArr.count)
  {
    //非最后一章的最后一页，加载下一章内容
    _currentChapter++;
    [self loadChapterContentWithIndex:_currentChapter];
    _currentIndex = 0;
  }else
  {
    //不是最后一页
    _currentIndex++;
  }

  return [self viewControllerAtIndex:_currentIndex];
}

/**
 避免手势拖动换页后又取消_currentIndex已经变化的BUG
 */
- (void)checkCurrentIndexAndCurrentChapter:(UIViewController *)viewController {
  DQMReaderContentViewController *nowViewController = (DQMReaderContentViewController *)viewController;
  _currentIndex = nowViewController.currentIndex;
  _currentChapter = nowViewController.currentChapter;
  NSLog(@"_currentIndex = %ld, _currentChapter = %ld",_currentIndex ,_currentChapter);
}






#pragma mark  - setter or getter
-(void)setToolViewShow:(BOOL)toolViewShow
{
  _toolViewShow = toolViewShow;
  self.pageViewController.view.userInteractionEnabled = !toolViewShow;
}
-(UIPageViewController *)pageViewController
{
  if(_pageViewController == nil)
  {
    _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
  }
  return _pageViewController;
}

-(DQMPageTopView *)topView
{
  if(_topView == nil)
  {
    _topView = [[DQMPageTopView alloc]initWithFrame:CGRectMake(0, -NAVIGATION_BAR_HEIGHT, kScreenWidth, NAVIGATION_BAR_HEIGHT)];
    _topView.hidden = YES;
    _topView.delegate = self;
  }
  return _topView;
}
-(DQMPageBottomView *)bottomView
{
  if(_bottomView == nil)
  {
    _bottomView = [[DQMPageBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight , kScreenWidth, TAB_BAR_HEIGHT+15)];
    _bottomView.hidden = YES;
    _bottomView.delegate = self;
  }
  return _bottomView;
  
}
-(DQMPageDirectoryView *)listView
{
  if(_listView == nil)
  {
    _listView = [[DQMPageDirectoryView alloc]initWithFrame:CGRectMake(-kScreenWidth*0.8, 0, kScreenWidth, kScreenHeight)];
    _listView.hidden = YES;
    _listView.delegate = self;
  }
  return _listView;
}


#pragma mark - dqm_navibar
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
  return NO;
}

@end

