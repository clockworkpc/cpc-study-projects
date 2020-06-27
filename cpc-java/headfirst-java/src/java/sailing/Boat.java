public class Boat {
  private Integer length;
  public void setLength ( Integer len ) {
    length = len;
  }

  public Integer getLength() {
    return length;
  }

  public void move() {
    System.out.print("drift\n");
  }
}
