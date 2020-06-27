public class BeerSong {
  static void beerLoop(int beerNum){
    while (beerNum > 0) {
      String bottle;
      if (beerNum == 1) {
        bottle = "bottle";
      } else {
        bottle = "bottles";
      }
      System.out.println(beerNum + " " + bottle + " " + "of beer on the wall");
      beerNum = beerNum - 1;
    }
    System.out.println("No more bottles of beer on the wall");
  }

  public static void main(String[] args) {
    beerLoop(10);
  }
}
