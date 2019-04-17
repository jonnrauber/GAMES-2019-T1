package;


class Boss extends Entity
{
    var _companyProdutivity:Int;

    public function new() {
        super();
        _companyProdutivity = 0;
    }

    override public function onMessage(m:Message):Void {
        super.onMessage(m);
    }
}