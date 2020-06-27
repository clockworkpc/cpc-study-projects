public class PhraseOMatic {

  public static void businessExpression() {
    String[] WordListOne = {"24/7", "30,000 foot", "B-to-B", "win-win", "frontend"};
    String[] WordListTwo = {"empowered", "sticky", "value-added"};
    String[] WordListThree = {"process", "tippingpoint", "solution"};

    int OneLength = WordListOne.length;
    int TwoLength = WordListTwo.length;
    int ThreeLength = WordListThree.length;

    int rand1 = (int) (Math.random() * OneLength);
    int rand2 = (int) (Math.random() * TwoLength);
    int rand3 = (int) (Math.random() * ThreeLength);

    String phrase = WordListOne[rand1] + " " + WordListTwo[rand2] + " " + WordListThree[rand3];
    System.out.println("What we need is a " + phrase);
  }

  public static void main(String[] args) {
    businessExpression();
  }
}
