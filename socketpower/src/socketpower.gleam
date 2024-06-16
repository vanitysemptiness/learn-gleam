import gleam/bytes_builder
import gleam/erlang/process
import gleam/option.{None}
import gleam/otp/actor
import glisten.{Packet}

/// clients request to join, we accept, queue them, pair them
/// then they are messaging eachother
/// the connection persists unless they disconnect or network issue
/// 
pub fn main() {
  let assert Ok(_) =
    glisten.handler(fn(_conn) { #(Nil, None) }, fn(msg, state, conn) {
      let assert Packet(msg) = msg
      let assert Ok(_) = glisten.send(conn, bytes_builder.from_bit_array(msg))
      actor.continue(state)
    })
    |> glisten.serve(3333)
  // use ssl later

  process.sleep_forever()
}
