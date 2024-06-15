import gleam/List


/// activation funcitons
pub fn sigmoid(x) {
    return 1.0 / (1.0 + exp(-x))
}

pub fn relu(x) {
    if x > 0.0 {
        return x
    } 
    return 0.0
}

/// neural net 
pub type nn {
    pub layers: List(Layer)

    // constructor
    pub fn new(layer_sizes: List(int), activation: fn(Float) -> Float) -> nn {
        // each layers input size is current size, and output size is next layers size
        let layers = for layer_size in layer_sizes {
            let input_size = layer_size
            let output_size = layer_sizes.next()
            let weights = random_matrix(input_size, output_size)
            let biases = random_vector(output_size)
            Layer(weights, biases, activation)
        }
        return NeuralNetwork(layers)
    }
}

pub type Layer {
    /// weights, biases, activation
    pub weights: Matrix
    pub biases: Vector
    pub activation: fn(Float) -> Float
}

