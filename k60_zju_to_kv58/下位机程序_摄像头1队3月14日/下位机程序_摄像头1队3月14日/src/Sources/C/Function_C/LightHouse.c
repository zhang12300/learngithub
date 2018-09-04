/******************************************************************************/
/*******************************************************************************
  文件名：灯塔程序文件LightHouse.c
  功  能：灯塔处理
  日  期：2015.05.11
  作  者：HJZ
  备  注：
*******************************************************************************/
/******************************************************************************/

#include "LightHouse.h"
uint8 LightHouseStateR0 = 0;    //灯塔接收模块0的状态
uint8 LightHouseStateR1 = 0;    //灯塔接收模块1的状态
uint8 LightHouseOn2OffFlag = 0;  //灯塔亮到暗的标志，从0到x变化，初始化为0.
uint8 LightHouseOff2OnFlag = 0;  //灯塔暗到亮的标志，从0到x变化，初始化为0.
uint8 LightHouseWaitStopFlag = 0;

  
uint8 LightHouseWaitStartGapCount;  //发车间隔计数值
uint8 LightHouseWaitStopGapCount;   //停车间隔计数值
uint16 LightHouseWaitStopDelayCount;  //停车延时判断计数值
uint8 LightHouseWaitStopDelayFlag;  //停车延时判断标志位
uint8 LightHouseWaitStopLockFlag;   //停车确认锁存标志位

uint16 LightHouseWaitStartMaxTime = 50;         //以0.1s为单位，50代表5秒。这么多秒后，不管有没有检测到灯塔，直接发车。
uint16 LightHouseWaitStopDelayCountLimit = 70;  //停车延时判断阈值，隔这么多个16ms才开始停车判断
uint16 LightHouseWaitStopGapCountLimit = 10;   //停车间隔计数阈值，每隔这么多个16ms就更新一次灯塔采集值。一般不要动。

uint16 LightHouseWaitStopOnCount = 0;         //停车时的，亮持续计数
uint16 LightHouseWaitStopOnCountLimit = 2;    //停车时的亮持续计数的阈值，与停车间隔计数有关，即亮度必须持续0.016*LightHouseWaitStopGapCountLimit*LightHouseWaitStopOnCountLimit秒。不需要太大。
uint16 LightHouseNoStopFlag = 0;              //灯塔不停车标志，1开启这种模式，不根据灯塔停车，直接冲过去。0关闭这种模式，根据灯塔停车。


//灯塔的亮到暗的检测，检测到跳变则返回1，否则返回0.
uint8 LightHouseOn2Off(void)
{
  if(LightHouseStateR0 == 0) //0表示亮
  {
    //初始状态是0，确认多次是亮。
    if(LightHouseOn2OffFlag == 0)
    {
      LightHouseOn2OffFlag = 1;
    }
    //确认一直是亮，则保持这个状态。
    else if(LightHouseOn2OffFlag == 1)
    {
      LightHouseOn2OffFlag = 1;
    }
    //从其它状态确认到亮，则返回初始状态。
    else
    {
      LightHouseOn2OffFlag = 0;
    }
  }
  else   //1表示暗
  {
    if(LightHouseOn2OffFlag == 1)
    {
      LightHouseOn2OffFlag = 2;
    }
    else if(LightHouseOn2OffFlag == 2)
    {
      LightHouseOn2OffFlag = 0;
      return 1;
    }
    else
    {
      LightHouseOn2OffFlag = 0;
    }
  }
  
  return 0;
  
}

//灯塔的暗到亮的检测,检测到跳变则返回1，否则返回0.
uint8 LightHouseOff2On(void)
{
  if(LightHouseStateR0 == 1) //1表示暗
  {
    //初始状态是0，确认多次是暗。
    if(LightHouseOff2OnFlag == 0)
    {
      LightHouseOff2OnFlag = 1;
    }
    //确认一直是暗，则保持这个状态。
    else if(LightHouseOff2OnFlag == 1)
    {
      LightHouseOff2OnFlag = 1;
    }
    //从其它状态确认到暗，则返回初始状态。
    else
    {
      LightHouseOff2OnFlag = 0;
    }
  }
  else   //0表示亮
  {
    if(LightHouseOff2OnFlag == 1)
    {
      LightHouseOff2OnFlag = 2;
    }
    else if(LightHouseOff2OnFlag == 2)
    {
      LightHouseOff2OnFlag = 0;
      return 1;
    }
    else
    {
      LightHouseOff2OnFlag = 0;
    }
  }
  
  return 0;
}



//======================================================================
//函数名：LightHouseWaitStart
//功  能：灯塔发车等待函数
//参  数：
//返  回：
//影  响：1等待 0发车
//说  明：1. 检测到亮到暗的跳变沿，则发车。
//        2. 注意对跳变沿的检测需要多几个点，防止小干扰。
//             
//======================================================================
uint8 LightHouseWaitStart(void)
{
  //间隔计数值加1.
  LightHouseWaitStartGapCount++;
  //实现多次更新一次值，达到滤波效果。发车的滤波可以小一些，节约一点时间。
  if(LightHouseWaitStartGapCount > LightHouseWaitStartGapCountLimit)
  {
    //灯塔信号更新
    LightHouseStateUpdate();
    //检测到亮到暗的跳变
    if(LightHouseOn2Off() == 1)
    {
      return 0;
    }
    else
    {
      return 1;
    }
  }
  else
  {
  }
  
  return 1;
}



//======================================================================
//函数名：LightHouseWaitStop
//功  能：灯塔发车等待函数
//参  数：
//返  回：
//影  响：1等待 0发车
//说  明：
//         
//             
//======================================================================
uint8 LightHouseWaitStop(void)
{
  //灯塔不停车标志，永远不停车。
  if(LightHouseNoStopFlag == 1)
  {
    return 1;
  }
  else
  {
  } 
  
  
  //确认停车后，就一直锁存住。
  if(LightHouseWaitStopLockFlag == 1)
  {
    return 0;
  }
  else
  {
  }
  
  //停车要延时判断，以免一发车就停车。
  if(LightHouseWaitStopDelayFlag == 0)
  {
    LightHouseWaitStopDelayCount++;
    //延时一段时间，可以设置久一些。
    if(LightHouseWaitStopDelayCount > LightHouseWaitStopDelayCountLimit * 63)
    {
      LightHouseWaitStopDelayFlag = 1;
    }
    else
    {
    }
  }
  else
  {
    //间隔计数值加1.
    LightHouseWaitStopGapCount++;
    //实现多次更新一次值，达到滤波效果。停车的滤波可以多一些，因为从拐角过来有可能会误判。
    if(LightHouseWaitStopGapCount > LightHouseWaitStopGapCountLimit)
    {
      //灯塔信号更新
      LightHouseStateUpdate();
      //1. 先检测到暗亮的跳变，再检测到亮暗的跳变
      if(LightHouseWaitStopFlag == 0)
      {
        //先检测到暗亮的跳变
        if(LightHouseOff2On() == 1)
        {
          //标志位变化
          LightHouseWaitStopFlag = 1;
          //亮持续计数清零。
          LightHouseWaitStopOnCount = 0;
        }
        else
        {
        }    
      }
      //2. 亮必须保持够久 
      else if(LightHouseWaitStopFlag == 1)
      {
        //若是亮，则计数加1
        if(LightHouseStateR0 == 0)
        {
          LightHouseWaitStopOnCount++;
          //亮连续计数到阈值，则标志位变化，同时清零。
          if(LightHouseWaitStopOnCount >= LightHouseWaitStopOnCountLimit)
          {
            //标志前进
            LightHouseWaitStopFlag = 2;
            LightHouseWaitStopOnCount = 0;
          }
          else
          {
          }
        }
        //一旦中途有变暗，则回到解放前。
        else
        {
          //标志后退
          LightHouseWaitStopFlag = 0;
        }
      }
      //3. 再检测亮到暗的跳变。
      else if(LightHouseWaitStopFlag == 2)
      {
        if(LightHouseOn2Off() == 1)
        {
          LightHouseWaitStopFlag = 3;
          return 0;
        }
        else
        {
        }
      }
      else if(LightHouseWaitStopFlag == 3)
      {
        //两次检测均成功，则不用再检测了。
        LightHouseWaitStopLockFlag = 1;
        return 0;    
      }
      else
      {
      }
    }
    else
    {
    }
  }
  
  return 1;
}

//======================================================================
//函数名：LightHouseInit
//功  能：灯塔初始化
//参  数：
//返  回：
//影  响：
//说  明：
//      
//             
//======================================================================
uint8 LightHouseInit(void)
{
  //LIGHTR0  灯塔接收模块1 复用为GPIO输入
  gpio_init(PORTE, 10, 0, 1);
  //LIGHTR1 灯塔接收模块2  复用为GPIO输入
  gpio_init(PORTE, 11, 0, 1);
  
  //间隔计数值初始化。
  LightHouseWaitStartGapCount = 0;
  LightHouseWaitStopGapCount = 0;
  //停车延时判断计数值初始化。
  LightHouseWaitStopDelayCount = 0;
  //停车延时判断标志位初始化。
  LightHouseWaitStopDelayFlag = 0;
  //停车确认锁存标志位
  LightHouseWaitStopLockFlag = 0;
  
  return 1;
}



//======================================================================
//函数名：LightHouseStateUpdate
//功  能：灯塔接收模块的状态更新
//参  数：
//返  回：
//影  响：
//说  明：
//      
//             
//======================================================================
uint8 LightHouseStateUpdate(void)
{
  //灯塔接收模块0的状态更新 E10
  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 10))
  {
    LightHouseStateR0 = 0;
  }
  else
  {
    LightHouseStateR0 = 1;
  }
  
//  //灯塔接收模块1的状态更新 E11
//  if(GPIO_PDIR_REG(PTE_BASE_PTR) & (1 << 11))
//  {
//    LightHouseStateR1 = 0;
//  }
//  else
//  {
//    LightHouseStateR1 = 1;
//  }
  
  
  return 1;
}

