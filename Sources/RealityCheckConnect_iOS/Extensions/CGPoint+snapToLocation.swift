import Foundation

func snapToLocation(
  containerSize: CGSize,
  predictedEndLocation: CGPoint
) -> CGPoint {
  let midWidth = containerSize.width / 2
  let midHeight = containerSize.height / 2
  var endLocation: CGPoint = .zero

  //Top Leading
  if predictedEndLocation.x < midWidth
    && predictedEndLocation.y < midHeight
  {
    endLocation = CGPoint(
      x: 88,
      y: 33
    )
  }
  //Top Trailing
  else if predictedEndLocation.x > midWidth
    && predictedEndLocation.y < midHeight
  {
    endLocation = CGPoint(
      x: containerSize.width - 88,
      y: 33
    )
  }
  //Bottom Leading
  else if predictedEndLocation.x < midWidth
    && predictedEndLocation.y > midHeight
  {
    endLocation = CGPoint(
      x: 88,
      y: containerSize.height - 66
    )
  }
  //Bottom Trailing
  else if predictedEndLocation.x > midWidth
    && predictedEndLocation.y > midHeight
  {
    endLocation = CGPoint(
      x: containerSize.width - 88,
      y: containerSize.height - 66
    )
  }

  return endLocation
}
