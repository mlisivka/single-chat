require ::File.expand_path('../config/environment',  __FILE__)
require 'faye'

# Load a WebSocket adapter for whichever server you're using
Faye::WebSocket.load_adapter 'thin'

use Faye::RackAdapter, :mount => '/faye', :timeout => 25
run Rails.application 