using System;
using System.Collections.Generic;

namespace ListExampleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create a list of strings
            List<string> names = new List<string>();

            // Add items to the list
            names.Add("Alice");
            names.Add("Bob");
            names.Add("Charlie");

            // Display the list
            Console.WriteLine("List of Names:");
            foreach (string name in names)
            {
                Console.WriteLine(name);
            }

            // Insert a name at a specific index
            names.Insert(1, "David");

            // Remove a name from the list
            names.Remove("Charlie");

            // Check if a name exists in the list
            bool containsAlice = names.Contains("Alice");

            Console.WriteLine("\nDoes the list contain 'Alice'? " + containsAlice);

            // Display the updated list
            Console.WriteLine("\nUpdated List of Names:");
            foreach (string name in names)
            {
                Console.WriteLine(name);
            }

            // Get the number of items in the list
            int count = names.Count;
            Console.WriteLine("\nTotal number of names in the list: " + count);

            // Clear the list
            names.Clear();

            // Check if the list is empty
            bool isEmpty = names.Count == 0;
            Console.WriteLine("\nIs the list empty? " + isEmpty);

            // Wait for user input before closing the console window
            Console.ReadLine();
        }
    }
}
