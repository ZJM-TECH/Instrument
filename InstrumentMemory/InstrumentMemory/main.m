//
//  main.m
//  InstrumentMemory
//
//  Created by JiaMeng.Zheng on 2019/4/30.
//  Copyright © 2019 live.bilibili.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}

/// 获取已用内存
vm_size_t getUsedMemory() {
    task_basic_info_data_t info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),TASK_BASIC_INFO,(task_info_t)&info,&size);
    if(kerr==KERN_SUCCESS) {
        return info.resident_size;
    } else {
        return 0;
    }
}

/// 获取可用内存
vm_size_t getFreeMemory() {
    mach_port_t host=mach_host_self();
    mach_msg_type_number_t size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vmstat;
    host_page_size(host,&pagesize);
    host_statistics(host,HOST_VM_INFO,(host_info_t)&vmstat,&size);
    return vmstat.free_count*pagesize;
}



