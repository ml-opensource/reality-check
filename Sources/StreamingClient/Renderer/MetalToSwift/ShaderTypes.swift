// If you encounter issues with SPM modules not being able to reference header files in Swift, one possible solution is to create a module map file that maps the module name to the header file or files containing the C or Objective-C declarations that need to be exposed to Swift code. However, if this approach doesn't work for you, an alternative workaround is to duplicate the enum declarations in the header file directly in this Swift file. This allows the Swift code to access the enum values without needing to reference the header file.

import Foundation

enum BufferIndices: Int {
  case kBufferIndexMeshPositions = 0
}

enum VertexAttributes: Int {
  case kVertexAttributePosition = 0
  case kVertexAttributeTexcoord = 1
}

enum TextureIndices: Int {
  case kTextureIndexY = 0
  case kTextureIndexCbCr = 1
}
