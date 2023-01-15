class Skin {
  String path = "C:\\Users\\Zrinka\\Desktop\\testProject\\assets";
  String ext = ".png";
  String sep  = "\\";
  
  public Skin(String... names){
    for(String name : names){
      if(name.length() < 5) {imgs.add(null); continue;}
      imgs.add(path + "\\" + name + ext);
    }
  }
  
  ArrayList<String> imgs = new ArrayList<String>();
}
