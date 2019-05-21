# Redraw

Redraw is a prototyping tool for create custom charts with [C3.js](http://c3js.org) and Rails. C3.js is the very flexible library based on D3.js for create the charts with [many options](https://github.com/c3js/c3/blob/master/src/config.js) and fine tuning result.

While you creating each chart you need try the many variations until you reach the final result, it's a bit tiring. This Gem allow work with the chart configuration as usual Ruby class containing hash-like DSL for save you time.

Currently project status is a **proof-of-concept** and not completed yet. Described below is worked but will change and can break existing functionality, use only in sandbox.

## Install

Add to Gemfile and then `bundle install`

```
gem 'redraw', git: 'git@github.com:creadone/redraw.git'
```

In `application.js` add:

```
//= require d3.min
//= require c3.min
```

## Quick Start

Make directory for the charts store. You can use any but most easy way to add it inside `/app` like `/app/charts`, in development Spring will be reload code on each change without editing Rails autoload path. Then for create the first chart put empty config file `/app/charts/line_chart.rb` and paste code below:

```Ruby
Redraw::Chart.new("LineChart").build do

  bindto 'container_name'
  data do
    columns [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data1', 50, 20, 10, 40, 15, 25]
    ]
  end

end
```

Now you can render chart in views:

```ERB
<%= redraw_chart 'LineChart' %>
```

## Todo
- [ ] Expose any config variables for the passing data from view
- [ ] Allow inline javascript like `format: d3.format('$,')`
- [ ] Writing javascript and css in config directly
- [ ] Caching config and delivering them through assets pipeline
- [ ] Adding tests after API completed
- [ ] Chart inheritance (may be)
- [ ] Baking charts into static files or building stand-alone widget (may be)
- [ ] Flexible config for interacting with D3 (may be)
- [ ] Get rid of Rails dependency (may be)
