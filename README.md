# DQM_ReaderBooks

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
  1.用显示文字的实际内容DQMReaderContentViewController作为缓存地方缓存对应的下标和章节    
  2.在上下页的回调中分别重置currnetIndex和CurrnetChapter     
  3.在目录点击回调的分别重置currnetIndex和CurrnetChapter 
  ![image](https://github.com/20120608/DQM_ReaderBooks/blob/master/DQM_ReaderBooks/BUG2.jpg)
     
        
             
        
        
        
  
  2.增加进度记录  未完成    
      
      
  3增加书签    未完成    
      
      
  4增加背景色选择  未完成    
      
      
  5修改目录样式  未完成    
      
          
  6.切换模式  未完成
      
          
  
  
