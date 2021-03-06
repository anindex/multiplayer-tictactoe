class HostScanner extends Thread
{
  public String serverAddress;
  public static final int TIMEOUT = 100;

  public HostScanner() 
  {
    try
    {
      Enumeration e = NetworkInterface.getNetworkInterfaces();
      while (e.hasMoreElements())
      {
        NetworkInterface n = (NetworkInterface) e.nextElement();
        Enumeration ee = n.getInetAddresses();
        while (ee.hasMoreElements())
        {
          InetAddress i = (InetAddress) ee.nextElement();
          if(!i.isLoopbackAddress() && i.isSiteLocalAddress())
          {
            serverAddress = String.valueOf(i.getHostAddress());
          }
        }
      }
    }
    catch(Exception e)
    {
      System.out.println("Local link network query failed! Scanner will not work!");
    }
  }

  public void run()
  {      
    int c = serverAddress.lastIndexOf(".");  
    String subnet = serverAddress.substring(0, c + 1);
    
    for(int i = 1; i <= 255; i++)
    {
      String host = subnet + String.valueOf(i);
      try
      {
        if (InetAddress.getByName(host).isReachable(TIMEOUT))
        {
          if(!host.equals(serverAddress))
          {
            textarea1.insertText(host, i - 2, 0);
          }          
        }
      }  
      catch(Exception e)
      {
        
      }  
    }
    
    label2.setText("Available Hosts");
  }
}
