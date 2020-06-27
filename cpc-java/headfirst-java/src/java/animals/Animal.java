public abstract class Animal implements Attribute {

//   Kingdom:	Animalia
// Phylum:	Chordata
// Class:	Mammalia
// Order:	Carnivora
// Family:	Canidae
// Genus:	Canis
// Species:	C. lupus
// Subspecies:	C. l. familiaris

  String animalName;

  public void setAnimalName(String name) {
    animalName = name;
  }

    public String getAnimalName() {
    return animalName;
  }

  public String attributeTemplate(String animalAttribute) {
    return "This" + " " + animalName + " " + "is" + " " + animalAttribute;
  }

  public String animalFeatureTemplate(String animalFeature) {
    return "This" + " " + animalName + " " + "has" + " " + animalFeature;
  }

  public String animalAbilityTemplate(String animalAbility) {
    return "This" + " " + animalName + " " + "can" + " " + animalAbility;
  }

  // Attribute

  public String animalKingdomMember() {
    return attributeTemplate("a member of the Animal kingdom");
  }

  public void isAnimalKingdomMember() {
    System.out.println(animalKingdomMember());
  }

  // Feature

  public String circulatorySystem() {
    return animalFeatureTemplate("a circulatory system");
  }

  public void hasCirculatorySystem() {
    System.out.println(circulatorySystem());
  }

  // Ability

  public String breathe() {
    return animalAbilityTemplate("breathe");
  }

  public void breathes() {
    System.out.println(breathe());
  }

  // public String eat() {
  //   return animalAbilityTemplate("eat");
  // }
  //
  // public void eats() {
  //   System.out.println(eat());
  // }
  //
  // public String sleep() {
  //   return animalAbilityTemplate("sleep");
  // }
  //
  // public void sleeps() {
  //   System.out.println(sleep());
  // }


  // public String eat() {
  //   return "This ANIMAL can eat";
  // }
  //
  // public String sleep() {
  //   return "This ANIMAL can sleep";
  // }
  //
  // public String reproduce() {
  //   return "This ANIMAL can reproduce";
  // }
  //
  // public String die() {
  //   return "This ANIMAL can die";
  // }
}
