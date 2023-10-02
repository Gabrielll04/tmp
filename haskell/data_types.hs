data Bool = False | True -- The part before the = denotes the type, which is Bool. The parts after the = are value constructors. They specify the different values that this type can have. The | is read as or. So we can read this as: the Bool type can have a value of True or False.
data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647
data Shape = Circle Float Float Float | Rectangle Float Float Float Float -- Your own type for 3D shapes. Hear, Circle and Rectangle are constructors, the Circle constructor ahs three fields (parameters) which accept Floats.
