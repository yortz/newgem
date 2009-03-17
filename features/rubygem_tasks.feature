Feature: Generated RubyGems have various rake tasks to aide their development
  In order to maintain and release generated RubyGems
  As a RubyGem developer
  I want rake tasks to perform routine maintenance and deployment tasks

  Scenario: Generate RubyGem
    Given an existing newgem scaffold [called 'my_project']
    And 'pkg' folder is deleted
    When I invoke task 'rake gem'
    Then folder 'pkg' is created
    And file with name matching 'pkg/my_project-0.0.1.gem' is created
    And gem spec key 'rdoc_options' contains /--mainREADME.rdoc/
    And gem spec key 'dependencies' contains /newgem \(>= [\d.]+, development\)/

  Scenario: Hoe does not bitch about README.txt being missing
    Given an existing newgem scaffold [called 'my_project'] that has 'README.rdoc' not 'README.txt'
    When I invoke task 'rake -T'
    Then output does not match /README.txt is missing/
  
  Scenario: Generate a gemspec that can build the RubyGem
    Given an existing newgem scaffold [called 'my_project']
    And 'pkg' folder is deleted
    When I invoke task 'rake gemspec'
    Then file 'my_project.gemspec' is created
    And gemspec builds the RubyGem successfully
    And output does match /Successfully built RubyGem/
  