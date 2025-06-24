fn main(x : Field, y : pub Field) {
    let y_squared = y * y;
    assert(x != y_squared, "x and y squared must be different");
}