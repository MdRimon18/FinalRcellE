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
    public object? CountryId { get; internal set; }
    public object? CountryCode { get; internal set; }
    public object? CntryShortName { get; internal set; }
    public object? LanguageId { get; internal set; }
    public object? CountryName { get; internal set; }
    public object? Capital { get; internal set; }
    public object? CurrencyId { get; internal set; }
    public object? CurrentArea { get; internal set; }
    public object? Population { get; internal set; }
    public object? EntryDateTime { get; internal set; }
    public object? EntryBy { get; internal set; }
    public object? LastModifyDate { get; internal set; }
    public object? LastModifyBy { get; internal set; }
    public object? DeletedDate { get; internal set; }
    public object? Status { get; internal set; }
    public object? DeletedBy { get; internal set; }
}
