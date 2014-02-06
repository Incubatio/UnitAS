package org.incubatio {

  import flash.utils.getQualifiedClassName;

  public class UnitAS {

    static public var messageTemplate:String = "{{a}} expected, {{b}} given";
    static public var resultTemplates:Object =  new Array("TEST MISERABLY FAILED", "TEST SUCCEED");


    static public var silent:Boolean = false;

    static public const VALUE:String = "Value";
    static public const TYPE:String  = "Type";

    protected var _result:uint = 1;
    protected var _i:uint = 1;

    // Following function can be erased to have a different output destination
    public function print(str:String = ""):void {
      trace(str);
    }

    /*public function UnitAS(testName:String, test:Function) {
      this.print();
      this.print(testName);
      test(this.assert);
      this.print(UnitAS.resultTemplates[this._result]);
    }*/

    public function start(testName:String, test:Function):void {
      this.print();
      this.print(testName);
      test(this.assert);
      this.print(UnitAS.resultTemplates[this._result]);
    }

    public static function test(testName:String, test:Function):void {
      var _test:UnitAS = new UnitAS();
      _test.start(testName, test);
    }

    
    // a is the expected result
    // b is the variable tested
    public function assert(a:*, b:*, msg:String = null):void {
      var errors:Array = [],
          strBuff:String,
          error:String;

      // Check Types
      if (getQualifiedClassName(a) !== getQualifiedClassName(b)) errors.push(UnitAS.TYPE);
      else {
        // Check values
        if (!equals(a, b)) errors.push(UnitAS.VALUE);
      }
     

      if (!silent) { 
        if(errors.length > 0) {
          this._result = 0;
          if(!msg) msg = UnitAS.messageTemplate;
          for each(error in errors) {
            //strBuff = msg.replace(/\{\{a\}\}/g, a.toString());
            //strBuff = strBuff.replace(/\{\{b\}\}/g, b.toString());
            strBuff = msg.replace(/\{\{a\}\}/g, JSON.stringify(a));
            strBuff = strBuff.replace(/\{\{b\}\}/g, JSON.stringify(b));
            this.print("    #" + this._i + " FAIL [" + error + " Error] " + strBuff );
          }
        } else this.print("    #" + this._i + " PASS");
      }
      this._i++;
    }


    public function equals(a:*, b:*):Boolean {
      var equalFunc:Function;
      switch(getQualifiedClassName(a)) {
        case "Object": equalFunc = this.objectEquals; break;
        case "Array": equalFunc = this.arrayEquals; break;
        default: equalFunc = this.classicEquals; break;
      }
      return equalFunc(a, b);
    }


    public function classicEquals(a:*, b:*):Boolean {
      var result:Boolean = false;
      try {
        result = a.equals(b);
      } catch(e:Error) {
        result = a === b;
      }
      return result;
    }

    // Check two ordered lists equality
    // TODO: depth checking
    public function arrayEquals(a:Array, b:Array):Boolean {
      var result:Boolean = a.length == b.length;
      if (result) {
        for (var i:* in a) {
          if (!this.equals(a[i], b[i])) { 
            result = false; 
            break; 
          }
        }
      }
      return result;
    }


    // Check that both object contain same properties
    // TODO: depth checking
    public function objectEquals(a:Object, b:Object):Boolean {
      var result:Boolean = true, i:*;
      for (i in a) {
        if (!this.equals(a[i], b[i])) { 
          result = false; 
          break; 
        }
      }
      if(result) {
        for (i in b) {
          if (!this.equals(a[i], b[i])) { 
            result = false; 
            break; 
          }
        }
      }
      return result;
    }
  }
}
