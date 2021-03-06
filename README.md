Lipa [![Build Status](https://secure.travis-ci.org/flipback/lipa.png)](http://travis-ci.org/flipback/lipa)
=======================================================

Lipa - DSL for description treelike structures in Ruby

Features
------------------------------------------------------
- Creating treelike structures for Ruby in DSL style
- Flexible syntax
- Supporting templates and scope initialization
- Supporting Proc object as attributes

Installation
-----------------------------------------------------
`gem install lipa`

Example
------------------------------------------------------

    require 'lipa'
    un = root :universe do 
      kind :planet_system do
        num_planet run{
          count = 0
          children.values.each do |planet|
            count += 1 if planet.kind == :planet
          end
          count
        }
      end

      kind :planet do 
        has_live false
        has_water false
        number 0
      end

      planet_system :sun_system do 
        planet :mercury do 
          number 1
          radius 46_001_210 
        end

        planet :venus do 
          number 2
          radius 107_476_259
        end

        planet :earth do 
          number 3
          radius 147_098_074
          has_live true
          has_water true

          node :moon, :radius => 363_104
        end
      end
    end

    un.sun_system.num_planet #=> 3
    un.sun_system.earth.radius #=> 147098074

Reference
----------------------------------
Home page: http://lipa.flipback.net

Web access to Lipa https://github.com/flipback/lipa-web
