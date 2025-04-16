Now we have the times of every program. How to transmit this time to have the duration?

You need to create a map!

![Diagram of transmission between program](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/82ew95hhzpxq2uum97lv.png)

But which type of map do we need to transmit data from a program to another program?

We could imagine an array with a single value. But if there are two binaries running at almost the same time, aren't we running the risk of false tracings?

![Diagram with array type](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4sk4roejofwe2edooy61.png)


A map per cpu array may seem attractive. But what if the input Tracepoint isn't on the same CPU as the output one?

![Diagram with per cpu array type](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/yq6irlvoabq2w3fjmlqh.png)

So we need to find another type of map to communicate between two separate eBPF programs.

One solution would be to create a dictionary with a single entry for the `sys_enter_execve` and `sys_exit_execve` tracepoint. That way, there would be no possibility of stepping on each other's toes.

![Diagram with hash type](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/fp2ybca9fm0xe6wunmq1.png)

But what could possibly link them? The **p**rocess **id**entifier (the famous **PID**) which executes the program.

To retrieve the PID, use the helper function [bpf_get_current_pid_tgid()]() :

![Aya Documentation of bpf_get_current_pid_tgid](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/hqqq4kqvilao41xc9l3x.png)

So we go with a `HashMap` with the tgid as input? It might work in the short term, but remember that eBPF maps have a fixed size. It would therefore fill up pretty quickly. So we'd need a way of purging at the end of processing to avoid this. Another solution would be to find a map that would do the job: `LruHashMap`. As we saw in the section on maps, it automatically deletes the least recent dictionary entries.

![eBPF documentation about LruHashMap](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/de0awhrdnd8c7bpgqu0h.png)
