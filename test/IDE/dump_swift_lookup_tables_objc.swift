// RUN: %target-swift-ide-test -dump-importer-lookup-table -source-filename %s -import-objc-header %S/Inputs/swift_name_objc.h > %t.log 2>&1
// RUN: FileCheck %s < %t.log

// RUN: %target-swift-ide-test -dump-importer-lookup-table -source-filename %s -import-objc-header %S/Inputs/swift_name_objc.h -enable-strip-ns-prefix > %t-omit-needless-words.log 2>&1
// RUN: FileCheck -check-prefix=CHECK-OMIT-NEEDLESS-WORDS %s < %t-omit-needless-words.log

// REQUIRES: objc_interop
// REQUIRES: OS=macosx

// CHECK-LABEL: <<Foundation lookup table>>
// CHECK:   NSTimeIntervalSince1970:
// CHECK:     TU: Macro
// CHECK: Categories:{{.*}}NSValue(NSValueCreation){{.*}}

// CHECK-LABEL: <<ObjectiveC lookup table>>
// CHECK-NEXT: Base name -> entry mappings:
// CHECK-NOT: lookup table
// CHECK:   NSObject:
// CHECK-NEXT:     TU: NSObject
// CHECK-NEXT:   NSObjectProtocol:
// CHECK-NEXT:     TU: NSObject

// CHECK-LABEL: <<Bridging header lookup table>>
// CHECK-NEXT:      Base name -> entry mappings:
// CHECK-NEXT:   CCItem:
// CHECK-NEXT:     TU: CCItemRef
// CHECK-NEXT:   CCItemRef:
// CHECK-NEXT:     TU: CCItemRef
// CHECK-NEXT:   CFTypeRef:
// CHECK-NEXT:     TU: CFTypeRef
// CHECK-NEXT:   NSAccessibility:
// CHECK-NEXT:     TU: NSAccessibility{{$}}
// CHECK-NEXT:   NSError:
// CHECK-NEXT:     TU: NSError
// CHECK-NEXT:   NSErrorImports:
// CHECK-NEXT:     TU: NSErrorImports
// CHECK-NEXT:   SNCollision:
// CHECK-NEXT:     TU: SNCollision{{$}}
// CHECK-NEXT:   SNCollisionProtocol:
// CHECK-NEXT:     TU: SNCollision{{$}}
// CHECK-NEXT:   SomeClass:
// CHECK-NEXT:     TU: SNSomeClass
// CHECK-NEXT:   SomeProtocol:
// CHECK-NEXT:     TU: SNSomeProtocol
// CHECK:        UIActionSheet:
// CHECK-NEXT:     TU: UIActionSheet
// CHECK-NEXT:   __swift:
// CHECK-NEXT:     TU: __swift
// CHECK-NEXT:   accessibilityFloat:
// CHECK-NEXT:     NSAccessibility: -[NSAccessibility accessibilityFloat]
// CHECK-NEXT:   badPointerMethodAndReturnError:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports badPointerMethodAndReturnError:]
// CHECK-NEXT:   blockMethod:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports blockMethodAndReturnError:]
// CHECK-NEXT:   categoryMethodWith:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass categoryMethodWithX:y:], -[SNSomeClass categoryMethodWithX:y:z:]
// CHECK:        doubleProperty:
// CHECK-NEXT:     SNSomeClass: SNSomeClass.doubleProperty
// CHECK-NEXT:   extensionMethodWith:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass extensionMethodWithX:y:]
// CHECK:        floatProperty:
// CHECK-NEXT:     SNSomeClass: SNSomeClass.floatProperty
// CHECK-NEXT:   functionPointerMethod:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports functionPointerMethodAndReturnError:]
// CHECK-NEXT:   init:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass initWithFloat:], -[SNSomeClass initWithDefault], +[SNSomeClass someClassWithDouble:], +[SNSomeClass someClassWithTry:], +[SNSomeClass buildWithUnsignedChar:]
// CHECK-NEXT:     UIActionSheet: -[UIActionSheet initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:]
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports initAndReturnError:], -[NSErrorImports initWithFloat:error:]
// CHECK-NEXT:   instanceMethodWith:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass instanceMethodWithX:Y:Z:]
// CHECK:        method:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports methodAndReturnError:], -[NSErrorImports methodWithFloat:error:]
// CHECK:        objectAtIndexedSubscript:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass objectAtIndexedSubscript:]
// CHECK-NEXT:   optSetter:
// CHECK-NEXT:     SNCollision: SNCollision.optSetter
// CHECK-NEXT:   pointerMethod:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports pointerMethodAndReturnError:]
// CHECK-NEXT:   protoInstanceMethodWith:
// CHECK-NEXT:     SNSomeProtocol: -[SNSomeProtocol protoInstanceMethodWithX:y:]
// CHECK:        reqSetter:
// CHECK-NEXT:     SNCollision: SNCollision.reqSetter
// CHECK-NEXT:   selectorMethod:
// CHECK-NEXT:     NSErrorImports: -[NSErrorImports selectorMethodAndReturnError:]
// CHECK-NEXT:   setAccessibilityFloat:
// CHECK-NEXT:     NSAccessibility: -[NSAccessibility setAccessibilityFloat:]
// CHECK-NEXT:   subscript:
// CHECK-NEXT:     SNSomeClass: -[SNSomeClass objectAtIndexedSubscript:]

// CHECK: Categories: SNSomeClass(), SNSomeClass(Category1)

// CHECK-OMIT-NEEDLESS-WORDS-LABEL: <<Foundation lookup table>>
// CHECK-OMIT-NEEDLESS-WORDS:   timeIntervalSince1970:
// CHECK-OMIT-NEEDLESS-WORDS:     TU: Macro

// CHECK-OMIT-NEEDLESS-WORDS: <<ObjectiveC lookup table>>
// CHECK-OMIT-NEEDLESS-WORDS-NOT: lookup table
// CHECK-OMIT-NEEDLESS-WORDS: responds:
// CHECK-OMIT-NEEDLESS-WORDS-NEXT:     -[NSObject respondsToSelector:]

// CHECK-OMIT-NEEDLESS-WORDS: Base name -> entry mappings:
// CHECK-OMIT-NEEDLESS-WORDS:   method:
// CHECK-OMIT-NEEDLESS-WORDS:     NSErrorImports: {{.*}}-[NSErrorImports methodWithFloat:error:]
