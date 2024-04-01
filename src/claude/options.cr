module Claude
  enum Action : UInt8
    Message
    Version
    Help
    None
  end

  struct Options
    property action : Action = Action::Message
    property model : String = ""
    property message : String = ""
    property files : Array(String) = Array(String).new
    property system_message : String?
    property max_tokens : UInt32 = 1024 # FIXME
    property metadata : String?
    property stop_sequence : String?
    property stream : Bool = false
    property temperature : Float32?
    property top_p : Float32?
    property top_k : UInt32?
  end
end
