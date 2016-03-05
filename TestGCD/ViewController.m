//
//  ViewController.m
//  TestGCD
//
//  Created by chaos on 2/1/16.
//  Copyright © 2016 ace. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i <10; i++) {
        dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.MyGCD", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(serialQueue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
        
    }
    
    
//    [self testSerial];
//    [self testConcurrent];
//    [self testSerial1];
//    [self testConcurrent1];
//    [self testPriority];
//    [self testTargetQueue];
//    [self testGroup];
//    [self testBarrier];
//    [self testApply];
//    [self testAfter];
//    [self testSemaphore1];
    [self testSemaphore2];
    
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.serial", NULL);
//
//    dispatch_async(serialQueue, ^{
//        NSLog(@"1");
//    });
//    
//    NSLog(@"2");
//    
//    dispatch_async(serialQueue, ^{
//        NSLog(@"3");
//    });
//    
//    NSLog(@"4");
}


- (void)testSerial
{
    dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.MyGCD", NULL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3");
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"4");
    });

    dispatch_async(serialQueue, ^{
        NSLog(@"5");
    });

}

- (void)testSerial1
{
    for (NSInteger i = 0; i<20; i++) {
        
        dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.MyGCD", NULL);
        
        dispatch_async(serialQueue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}

- (void)testConcurrent1
{
    for (NSInteger i = 0; i<20; i++) {
        
        dispatch_queue_t concurrentQueue = dispatch_queue_create("com.gcd.MyGCD", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(concurrentQueue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}




- (void)testConcurrent
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.gcd.MyGCD", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2");
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"3");
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"4");
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"5");
    });
    
}

- (void)testPriority
{
//    dispatch_queue_t mainDisptachQueue = dispatch_get_main_queue();
    
    dispatch_queue_t highQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_queue_t lowQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);

    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    dispatch_async(backgroundQueue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(lowQueue, ^{
        NSLog(@"2");
    });

    dispatch_async(defaultQueue, ^{
        NSLog(@"3");
    });
    
    dispatch_async(highQueue, ^{
        NSLog(@"4");
    });

    
//    dispatch_set_target_queue(defaultQueue, highQueue);
//    
//      dispatch_set_target_queue(lowQueue, highQueue);
//    
//      dispatch_set_target_queue(backgroundQueue, highQueue);
//    
//      dispatch_set_target_queue(mainDisptachQueue, highQueue);
    
//    dispatch_async(mainDisptachQueue, ^{
//        NSLog(@"5");
//    });


//    NSLog(@"6");
}

- (void)testTargetQueue
{

    
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.target.queue1", NULL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.target.queue2", NULL);
    dispatch_queue_t serialQueue3 = dispatch_queue_create("com.target.queue3", NULL);
    dispatch_queue_t serialQueue4 = dispatch_queue_create("com.target.queue4", NULL);
    dispatch_queue_t serialQueue5 = dispatch_queue_create("com.target.queue5", NULL);

    dispatch_set_target_queue(serialQueue2, serialQueue1);
    dispatch_set_target_queue(serialQueue3, serialQueue1);
    dispatch_set_target_queue(serialQueue4, serialQueue1);
    dispatch_set_target_queue(serialQueue5, serialQueue1);
    
    dispatch_async(serialQueue1, ^{
        NSLog(@"1");
    });
    
    dispatch_async(serialQueue2, ^{
        NSLog(@"2");
    });
    
    dispatch_async(serialQueue3, ^{
        NSLog(@"3");
    });
    
    dispatch_async(serialQueue4, ^{
        NSLog(@"4");
    });
    
    dispatch_async(serialQueue5, ^{
        NSLog(@"5");
    });
    
//    NSLog(@"6");
}

- (void)testGroup
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"4");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"5");
    });

    
//    long result = dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)));
//    if (result == 0) {
//        NSLog(@"处理结束");
//    }else{
//        NSLog(@"处理中");
//    }
//    NSLog(@"5555");

}

- (void)testBarrier
{
//      dispatch_queue_t queue = dispatch_queue_create("com.barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
    dispatch_async(queue, ^{
        NSLog(@"正在读1。。。");
    });
    dispatch_async(queue, ^{
        NSLog(@"正在读2。。。");
    });
    dispatch_async(queue, ^{
        NSLog(@"正在读3。。。");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"正在写1。。。");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"正在写2。。。");
    });

    dispatch_async(queue, ^{
        NSLog(@"写后继续读1。。。");
    });
    dispatch_async(queue, ^{
        NSLog(@"写后继续读2。。。");
    });
    dispatch_async(queue, ^{
        NSLog(@"写后继续读3。。。");
    });

}

- (void)testApply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t queue = dispatch_queue_create("com.apply", DISPATCH_QUEUE_SERIAL);


//    dispatch_apply(10, queue, ^(size_t index) {
//        NSLog(@"%zu",index);
//    });
    
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    
    dispatch_apply([array count], queue, ^(size_t index) {
        NSLog(@"%@",[array objectAtIndex:index]);
    });

    
    NSLog(@"done");
}


- (void)testAfter
{
    NSLog(@"before");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"after");
    });
    [NSThread sleepForTimeInterval:5];
}

- (void)testSemaphore
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    NSString *str = @"5";
    for (int i = 0; i < 10000; i ++) {
        dispatch_async(queue, ^{
            [array addObject:str];
        });
    }
}

- (void)testSemaphore1
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSLog(@"1。。。");

    for (int i = 0; i < 1000000; i ++) {
        dispatch_async(queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
//            NSLog(@"%@",[NSThread currentThread]);
            [array addObject:[NSNumber numberWithInt:i]];
            
            dispatch_semaphore_signal(semaphore);
        });
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"%lu",(unsigned long)array.count);
        NSLog(@"正在写1。。。");
    });

}

- (void)testSemaphore2
{

    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    NSLog(@"2。。。");
    
    for (int i = 0; i < 1000000; i ++) {
        [array addObject:[NSNumber numberWithInt:i]];

    }
    NSLog(@"%lu",(unsigned long)array.count);
    NSLog(@"正在写2。。。");
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
