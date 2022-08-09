<h1>Welcome to my ENIGMA machine!</h1>

<h2>Functionality</h2>

I was able to successfully implement CLI runner files for Encryption, Decryption, and Cracking functions.
There is currently a bug in my Cracking function that throws an error if the ' character appears in the original message.
All other characters are handled successfully.

<h2>Object-Oriented Programming</h2>

I have implemented both Inheritance and Modules in this code.

The CodeCracker class is a Decryptor that is capable of cracking a key given only the date of a message's original encryption and allowing for the fact that the last four characters in that message are ' end'. The Decryptor itself does not need access to the key cracking functionality as it is designed to decipher a message with a provided key, but the CodeCracker must have access to the entire suite of decryption functionality in order to provide output once the key has been deciphered.

The Cryptable module contains three modules that are integral to the function of both Encryptor and Decryptor classes, and thus it made sense to me to include this module in both classes rather than repeating them in each. These methods were originally implemented in the original Enigma class, and I think a case could be made for either implementation, but I felt that it didn't make sense to have an entire class for three basic methods. The use of a module felt more appropriate.

<h2>Ruby Conventions and Mechanics</h2>

I used a variety of enumerables to achieve the necessary results across this project. There are a number of instances in which #each seemed to be the only way to achieve what I was looking for, especially in cases where very complex nested collections were in play. Generally, where another method was viable, I used it.

The #generate_key_array method in my CodeCracker class caused me no end of heartache, and is arguably longer than ten lines (rubocop says it's eleven), though I count it at nine. This was the only instance in the project where I was unable to simplify my logic further without disrupting my results. Otherwise, my methods all fall within the guidelines of the project.

I used rubocop extensively to ensure correct indentation & spacing, proper use of single and double quotes, etc... All classes, modules, runners, and test files have top-line documentation comments.

<h2>Test-Driven Development</h2>

SimpleCov results show 100% coverage on my code. All testing was written prior to building code, first using the interaction pattern supplied in the product guidelines, later to reflect the structure of the project as it changed. All methods, including helper methods, are tested.

Stubs were used to test the #keygen method, which allows the Encryptor class to generate a unique five-digit key when encrypting a message. Since the output was random, this was an excellent use-case for stubbing, as it would have otherwise been impossible to properly test.

I used mocks when testing my crack method, in order to remove the need to include the functionality of the Encryptor class while testing cracking methods. This brought my testing flow more in line with convention, and probably also created some very small gains in terms of testing performance that would be more noticeable if we were testing with extremely long text files.

<h2>Version Control</h2>

I used pull requests and commits to track and document my progress at every step of this project, far exceeding the minimum requirements for number of requests and commits. I used branches extensively to work on new features without disrupting working code, and was careful to delete them once I'd finished with each new feature, in order to maintain organization and cleanliness.

I probably could have done a better job with naming some pull requests, or been more selective about when and I why I was making a pull request, since I sometimes had a tendency to save my work too frequently when I could have waited to pull after more commits. My frequent use of branching did often necessitate a pull request, so that I'd be able to merge my work into main and then continue working on the next branch.

I think I have a long ways to go in learning the intricacies of github, but I feel comfortable saying that it was a tool I made good use of in this project.