// CountryService.cs

using System;
using System.Collections.Generic;
using System.Linq;

public class CountryService
{
    private List<Country> countries;

    public CountryService()
    {
        // Initialize the list of countries here
        countries = new List<Country>
        {
            new Country { Id = 1, Name = "Country 1" },
            new Country { Id = 2, Name = "Country 2" },
            // Add more countries as needed
        };
    }

    public List<Country> GetCountries()
    {
        return countries;
    }

    public Country GetCountryById(int id)
    {
        return countries.FirstOrDefault(c => c.Id == id);
    }
}

public class Country
{
    public int Id { get; set; }
    public string Name { get; set; }
}
