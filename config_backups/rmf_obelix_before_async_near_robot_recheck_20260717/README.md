# 异步复检与近机体宽容检查改造前备份

备份时间：2026-07-17。

本目录保存以下改造前的文件：

- `gbplanner/validate_path` 使用独立 ROS 回调队列和线程。
- 缓存路径前 `0.8m` 使用真实机体盒复检。
- 路径后续部分仍使用 `size + size_extension_min` 最小安全盒。

本次不放宽整条路径，不忽略 occupied/unknown，也不关闭 Global 边界检查。
