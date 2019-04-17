package;


class Message {
    public static inline var OP_GO_WORK:Int = 0;

    public var from:Entity;
    public var to:Entity;
    public var data:Float;
    public var op:Int;

    public function new() {}


}