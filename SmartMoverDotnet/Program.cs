using Newtonsoft.Json;
using System.Security.Cryptography;

namespace SmartMoverDotnet
{
  static class Program
  {

    static void Main(string[] args)
    {
      string baseServiceUrl = @"https://smartmover.melissadata.net/";
      string serviceEndpoint = @"V3/WEB/SmartMover/doSmartMover";
      string license = "";
      string pafid = "";
      string company = "";
      string fullName = "";
      string addressLine1 = "";
      string city = "";
      string state = "";
      string postalCode = "";
      string country = "";

      ParseArguments(ref license, ref pafid, ref company, ref fullName, ref addressLine1, ref city, ref state, ref postalCode, ref country, args);
      CallAPI(baseServiceUrl, serviceEndpoint, license, pafid, company, fullName, addressLine1, city, state, postalCode, country);
    }

    static void ParseArguments(ref string license, ref string pafid, ref string company, ref string fullName, ref string addressLine1, ref string city, ref string state, ref string postalCode, ref string country, string[] args)
    {
      for (int i = 0; i < args.Length; i++)
      {
        if (args[i].Equals("--license") || args[i].Equals("-l"))
        {
          if (args[i + 1] != null)
          {
            license = args[i + 1];
          }
        }
        if (args[i].Equals("--pafid"))
        {
          if (args[i + 1] != null)
          {
            pafid = args[i + 1];
          }
        }
        if (args[i].Equals("--company"))
        {
          if (args[i + 1] != null)
          {
            company = args[i + 1];
          }
        }
        if (args[i].Equals("--fullname"))
        {
          if (args[i + 1] != null)
          {
            fullName = args[i + 1];
          }
        }
        if (args[i].Equals("--addressline1"))
        {
          if (args[i + 1] != null)
          {
            addressLine1 = args[i + 1];
          }
        }
        if (args[i].Equals("--city"))
        {
          if (args[i + 1] != null)
          {
            city = args[i + 1];
          }
        }
        if (args[i].Equals("--state"))
        {
          if (args[i + 1] != null)
          {
            state = args[i + 1];
          }
        }
        if (args[i].Equals("--postalcode"))
        {
          if (args[i + 1] != null)
          {
            postalCode = args[i + 1];
          }
        }
        if (args[i].Equals("--country"))
        {
          if (args[i + 1] != null)
          {
            country = args[i + 1];
          }
        }
      }
    }

    public static async Task GetContents(string baseServiceUrl, string requestQuery)
    {
      HttpClient client = new HttpClient();
      client.BaseAddress = new Uri(baseServiceUrl);
      HttpResponseMessage response = await client.GetAsync(requestQuery);

      string text = await response.Content.ReadAsStringAsync();
      var obj = JsonConvert.DeserializeObject(text);
      var prettyResponse = JsonConvert.SerializeObject(obj, Newtonsoft.Json.Formatting.Indented);

      // Print output
      Console.WriteLine("\n================================== OUTPUT ==================================\n");

      Console.WriteLine("API Call: ");
      string APICall = Path.Combine(baseServiceUrl, requestQuery);
      for (int i = 0; i < APICall.Length; i += 70)
      {
        if (i + 70 < APICall.Length)
        {
          Console.WriteLine(APICall.Substring(i, 70));
        }
        else
        {
          Console.WriteLine(APICall.Substring(i, APICall.Length - i));
        }
      }

      Console.WriteLine("\nAPI Response:");
      Console.WriteLine(prettyResponse);
    }
    static void CallAPI(string baseServiceUrl, string serviceEndPoint, string license, string pafid, string company, string fullName, string addressLine1, string city, string state, string postalCode, string country)
    {
      Console.WriteLine("\n================= WELCOME TO MELISSA SMART MOVER CLOUD API =================\n");

      bool shouldContinueRunning = true;

      while (shouldContinueRunning)
      {
        string inputPafid = "";
        string inputCompany = "";
        string inputFullName = "";
        string inputAddressLine1 = "";
        string inputCity = "";
        string inputState = "";
        string inputPostalCode = "";
        string inputCountry = "";

        if (string.IsNullOrEmpty(pafid) && string.IsNullOrEmpty(company) && string.IsNullOrEmpty(fullName) && string.IsNullOrEmpty(addressLine1) && string.IsNullOrEmpty(city) && string.IsNullOrEmpty(state) && string.IsNullOrEmpty(postalCode) && string.IsNullOrEmpty(country))
        {
          Console.WriteLine("\nFill in each value to see results");

          Console.Write("Pafid: ");
          inputPafid = Console.ReadLine();

          Console.Write("Company: ");
          inputCompany = Console.ReadLine();

          Console.Write("FullName: ");
          inputFullName = Console.ReadLine();

          Console.Write("Addressline1: ");
          inputAddressLine1 = Console.ReadLine();

          Console.Write("City: ");
          inputCity = Console.ReadLine();

          Console.Write("State: ");
          inputState = Console.ReadLine();

          Console.Write("PostalCode: ");
          inputPostalCode = Console.ReadLine();

          Console.Write("Country: ");
          inputCountry = Console.ReadLine();
        }
        else
        {
          inputPafid = pafid;
          inputCompany = company;
          inputFullName = fullName;
          inputAddressLine1 = addressLine1;
          inputCity = city;
          inputState = state;
          inputPostalCode = postalCode;
          inputCountry = country;
        }

        while (string.IsNullOrEmpty(inputPafid) || string.IsNullOrEmpty(inputCompany) || string.IsNullOrEmpty(inputFullName) || string.IsNullOrEmpty(inputAddressLine1) || string.IsNullOrEmpty(inputCity) || string.IsNullOrEmpty(inputState) || string.IsNullOrEmpty(inputPostalCode) || string.IsNullOrEmpty(inputCountry))
        {
          Console.WriteLine("\nFill in missing required parameter");

          if (string.IsNullOrEmpty(inputPafid))
          {
            Console.Write("Pafid: ");
            inputPafid = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputCompany))
          {
            Console.Write("Company: ");
            inputCompany = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputFullName))
          {
            Console.Write("FullName: ");
            inputFullName = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputAddressLine1))
          {
            Console.Write("Addressline1: ");
            inputAddressLine1 = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputCity))
          {
            Console.Write("City: ");
            inputCity = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputState))
          {
            Console.Write("State: ");
            inputState = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputPostalCode))
          {
            Console.Write("PostalCode: ");
            inputPostalCode = Console.ReadLine();
          }

          if (string.IsNullOrEmpty(inputCountry))
          {
            Console.Write("Country: ");
            inputCountry = Console.ReadLine();
          }
        }

        Dictionary<string, string> inputs = new Dictionary<string, string>()
                {
                    { "format", "json" },
                    { "pafid", inputPafid },
                    { "comp", inputCompany },
                    { "full", inputFullName },
                    { "a1", inputAddressLine1 },
                    { "city", inputCity },
                    { "state", inputState },
                    { "postal", inputPostalCode },
                    { "ctry", inputCountry }
                };

        Console.WriteLine("\n================================== INPUTS ==================================\n");
        Console.WriteLine($"\t   Base Service Url: {baseServiceUrl}");
        Console.WriteLine($"\t  Service End Point: {serviceEndPoint}");
        Console.WriteLine($"\t              Pafid: {inputPafid}");
        Console.WriteLine($"\t            Company: {inputCompany}");
        Console.WriteLine($"\t           FullName: {inputFullName}");
        Console.WriteLine($"\t       AddressLine1: {inputAddressLine1}");
        Console.WriteLine($"\t               City: {inputCity}");
        Console.WriteLine($"\t              State: {inputState}");
        Console.WriteLine($"\t         PostalCode: {inputPostalCode}");
        Console.WriteLine($"\t            Country: {inputCountry}");

        // Create Service Call
        // Set the License String in the Request
        string RESTRequest = "";

        RESTRequest += @"&id=" + Uri.EscapeDataString(license);

        // Set the Input Parameters
        foreach (KeyValuePair<string, string> kvp in inputs)
          RESTRequest += @"&" + kvp.Key + "=" + Uri.EscapeDataString(kvp.Value);

        // Build the final REST String Query
        RESTRequest = serviceEndPoint + @"?" + RESTRequest;

        // Submit to the Web Service. 
        bool success = false;
        int retryCounter = 0;

        do
        {
          try //retry just in case of network failure
          {
            GetContents(baseServiceUrl, $"{RESTRequest}").Wait();
            Console.WriteLine();
            success = true;
          }
          catch (Exception ex)
          {
            retryCounter++;
            Console.WriteLine(ex.ToString());
            return;
          }
        } while ((success != true) && (retryCounter < 5));

        bool isValid = false;
        if (!string.IsNullOrEmpty(pafid + company + fullName + addressLine1 + city + state + postalCode + country))
        {
          isValid = true;
          shouldContinueRunning = false;
        }

        while (!isValid)
        {
          Console.WriteLine("\nTest another record? (Y/N)");
          string testAnotherResponse = Console.ReadLine();

          if (!string.IsNullOrEmpty(testAnotherResponse))
          {
            testAnotherResponse = testAnotherResponse.ToLower();
            if (testAnotherResponse == "y")
            {
              isValid = true;
            }
            else if (testAnotherResponse == "n")
            {
              isValid = true;
              shouldContinueRunning = false;
            }
            else
            {
              Console.Write("Invalid Response, please respond 'Y' or 'N'");
            }
          }
        }
      }

      Console.WriteLine("\n================== THANK YOU FOR USING MELISSA CLOUD API ===================\n");
    }
  }
}
