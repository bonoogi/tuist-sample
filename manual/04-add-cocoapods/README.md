# 1. ManualApp.xcconfig 을 Debug, Release로 분리
`#include "Pods/Target Support Files/Pods-Manual/Pods-Manual.debug.xcconfig"`
`*#include "Pods/Target Support Files/Pods-Manual/Pods-Manual.release.xcconfig"`
가 config별로 분리되어있어 앱 컨픽도 분리되어서 들어가야 함
이 처리를 안하면 `PODS_ROOT` 등의 CocoaPods에 의해 적용되는 커스텀 빌드 세팅이 적용되지 않아 빌드할 수 없다.

# 2. ManualProject.xcconfig 의 잘못된 Preprocessor Definition 수정
`$ tuist migration settings-to-xcconfig -p Manual.xcodeproj -x ManualProject.xcconfig`
위 명령어로 프로젝트 설정을 추출하면 다음과 같은 설정이 들어감
`GCC_PREPROCESSOR_DEFINITIONS[config=Debug]=["DEBUG=1", "$(inherited)"]`
그런데 이게 문법상으로 맞지 않아 빌드시에 매크로 관련해 아래와 같이 잘못 지정되었다는 오류가 발생함

```
<built-in>:378:2: note: in file included from <built-in>:378:
# 1 "<command line>" 1
 ^
<command line>:17:9: error: macro name must be an identifier
#define [DEBUG 1,
        ^
<built-in>:378:2: note: in file included from <built-in>:378:
# 1 "<command line>" 1
 ^
<command line>:18:9: error: macro name must be an identifier
#define ] 1
        ^
<built-in>:378:2: note: in file included from <built-in>:378:
# 1 "<command line>" 1
 ^
<command line>:17:9: error: macro name must be an identifier
#define [DEBUG 1,
        ^
<built-in>:378:2: note: in file included from <built-in>:378:
# 1 "<command line>" 1
 ^
<command line>:18:9: error: macro name must be an identifier
#define ] 1
        ^
```
다음과 같이 수정하고 다시 `tuist generate`를 실행하면 문제가 해결된다.
`GCC_PREPROCESSOR_DEFINITIONS[config=Debug]=DEBUG=1 $(inherited)`



