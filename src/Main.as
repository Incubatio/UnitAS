package {

  import flash.display.Sprite;
  import org.incubatio.UnitAS;
  import flash.desktop.NativeApplication;
  import flash.utils.getQualifiedClassName;

  public class Main extends Sprite {
    public function Main() {

      UnitAS.test("Test from space", function(assert:Function):void {

        // Your tests here
        var expected:uint = 1;
        var actual:uint = 1;

        // success example
        assert(expected, actual);

        // fail example with a default message and type error
        assert(expected, "IamAString");

        // fail example with custom message and value
        assert(expected, 2, "Dude you can't get {{a}} by just breaking some {{b}}");


      });

      NativeApplication.nativeApplication.exit();

    }
  }

}
