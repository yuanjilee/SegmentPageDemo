# SegmentPageDemo


## 遇到的问题

- 同时创建多个页面的内存问题： `-ScrollViewDidScroll` 代理滑动到当期那页面的时候再创建，避免在开始加载的时候就创建了所有页面导致耗费太多时间以及不必要的内存损耗。

- iPad 横屏适配： `PadingEnabl ScrollView` 的滑动后，旋转屏幕，改变 `ContentSize & ContentOffSet` 以及子 `View` 的约束。