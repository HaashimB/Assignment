class Circle_Location
{
  Float[] locx;
  Float[] locy;
  Circle_Location()
  {
    for(int i = 0;i<10;i++)//for loop to check circles are in unique x locations
    {
      locx[i] = random(0,width);
      
      for(int j = 0;j < i;j++)
      {
        if(locx[i]==locx[j])
        {
          i-=1;
        }
      }
    }
    for(int i = 0;i<checker;i++)//for loop to check circles are in unique y locations
    {
      locy[i] = random(0,height);
      for(int j = 0;j < i;j++)
      {
        if(locy[i]==locy[j])
        {
          i-=1;
        }
      }
    }
     
    
    
