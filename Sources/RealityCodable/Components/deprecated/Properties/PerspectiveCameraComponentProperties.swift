import Foundation

public struct PerspectiveCameraComponentProperties: ComponentPropertiesRepresentable {
	/// The minimum distance in meters from the camera that the camera can see.
	///
	/// The value defaults to 1 centimeter. Always use a value greater than `0`
	/// and less than the value of ``PerspectiveCameraComponent/far``. The
	/// renderer clips any surface closer than the
	/// ``PerspectiveCameraComponent/near`` point.
	public let near: Float

	/// The maximum distance in meters from the camera that the camera can see.
	///
	/// The value defaults to infinity. Always use a value greater than the
	/// value of ``PerspectiveCameraComponent/near``. The renderer clips any
	/// surface beyond the ``PerspectiveCameraComponent/far`` point.
	public let far: Float

	/// The camera’s total vertical field of view in degrees.
	///
	/// This property contains the entire vertifical field of view for the
	/// camera in degrees. The system automatically calculates the horizontal
	/// field of view from this value to fit the aspect ratio of the device’s
	/// screen.
	///
	/// This property defaults to `60` degrees.
	public let fieldOfViewInDegrees: Float
}
