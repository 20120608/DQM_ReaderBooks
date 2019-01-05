# DQM_ReaderBooks


# 已知BUG,在某一些特定的章节会出现重复，还没有定位问题。基本不影响使用。



1.解决问题    
字体大小变化导致的数组越界
//重新计算分页    
  [self loadChapterContentWithIndex:_currentChapter];    
  self.currentVC.content = self.pageContentArray[_currentIndex];    
  替换为    
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
        
        
  翻页手势执行一半放回，上一页/下一页的代码却执行了的BUG,而且UIPage的手势容易导致重复页码
  解决方法:  
  0.仍存在部分章节到下一章节时会重复的问题    
  1.用显示文字的实际内容DQMReaderContentViewController作为缓存地方缓存对应的下标和章节    
  2.在上下页的回调中分别重置currnetIndex和CurrnetChapter     
  3.在目录点击回调的分别重置currnetIndex和CurrnetChapter 
  ![image](https://github.com/20120608/DQM_ReaderBooks/blob/master/DQM_ReaderBooks/BUG2.jpg)
     
        
             
        
        
        
  
  2.增加进度记录  完成    
    补充:用了FMDB，刚进入有点卡顿，可以考虑改成异步加载同时显示HUD的方式,有时间再补充。因为是每章解析速度快，不是很影响使用
      
  3.增加背景色选择  完成
  现在是分成白天和黑夜，各有十种背景图提供选择。
      
4.定位到指定目录章节 完成
点击菜单的时候获取当前视图的章的数字并定位到tableView的cell;    

5.加载网络图书。  完成
需要用到AFNetworking进行书本下载操作;DEMO在第二个分页    

  
  
