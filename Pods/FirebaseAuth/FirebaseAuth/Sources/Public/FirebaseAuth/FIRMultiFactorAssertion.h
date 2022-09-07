/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** @class FIRMultiFactorAssertion
    @brief The base class for asserting ownership of a second factor. This is equivalent to the
        AuthCredential class.
        This class is available on iOS only.
*/
NS_SWIFT_NAME(MultiFactorAssertion) API_UNAVAILABLE(macos, tvos, watchos)
    @interface FIRMultiFactorAssertion : NSObject

/**
   @brief The second factor identifier for this opaque object asserting a second factor.
*/
@property(nonatomic, readonly, nonnull) NSString *factorID;

@end

NS_ASSUME_NONNULL_END
