public class MyFirstApp{
  static int whileLoopExample() {
    int x = 3;
    x = x * 17;

    while (x > 12) {
      x = x - 1;
      System.out.println(x);
    }
    return x;
  }

  static int forLoopExample() {
    int result = 0;
    for (int y = 0; y < 10; y = y +1 ) {
      result = result = y;
      System.out.println("result is now " + result);
    }
    return result;
  }

  static void whileLoopExampleValue(){
    whileLoopExample();
  }

  static void forLoopExampleValue(){
    forLoopExample();
  }

  static void ifElseExample(int x){
    System.out.printf("x = " + x + ", which means that... ");
    if (x == 3) {
      System.out.println("x is indeed 3");
    } else {
      System.out.println("x is certainly not 3");
    }
    System.out.println("Just doing my thing");
  }

  static void whileIfElseExample(int x){
    while (x > 0) {
      ifElseExample(x);
      x = x - 1;
    }
  }

  public static void main (String[] args) {
    whileLoopExampleValue();
    forLoopExampleValue();
    ifElseExample(2);
    ifElseExample(3);
    whileIfElseExample(10);
  }
}
