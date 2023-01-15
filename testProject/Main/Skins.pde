class Skin {
  String ext = ".png";
  String sep  = "\\";
  
  public Skin(String... names){
    for(String name : names){
      if(name.length() < 5) {imgs.add(null); continue;}
      imgs.add(path + "\\assets\\" + name + ext);
    }
  }
  
  ArrayList<String> imgs = new ArrayList<String>();
}
