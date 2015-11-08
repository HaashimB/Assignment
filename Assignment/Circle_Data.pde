class Circle_Data
{
  String titles;
  Float players;
  
  Circle_Data(String line)
  {
    String[] parts = line.split(",");
    titles = parts[0];
    players = Float.parseFloat(parts[1]) ;
  }
  
}

