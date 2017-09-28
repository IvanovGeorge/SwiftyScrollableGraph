# SwiftyScrollableGraph


It's an easy to setup and use scrollable graph view for swift. Customizable, fast and clean.


Installing

Easy as adding this to your podFile

pod 'SwiftyScrollableGraph'

Using

1) Add view on your viewcontroller in storyboard
2) Set it as "SwiftyScrollableGraph" Class and make an outlet to your code. Now it's ready to use!
3) To add data and draw first graph, just call in viewDidLoad(or anywhere you need) yourSwiftyScrollableGraph.reloadGraphWith(pointsData: [(value: 11, description: "Jan."),(value: 2, description: "Feb."),(value: 33, description: "Mar."),(value: 0, description: "Apr.")])
pointsData - is an array of values and description. Values used for point yAxis coordinates, and description for desciption via or(and) xAxys labels. 
Now it's ready! You should see somthing like this:

Now, you want to make some customiztion. Just see this commands and theyr description (or check the SampleProject)

reloadGraphWith(pointsData: [(value: Int, description: String)]) // loads data to graph and draw it.

autoScroll = Bool // true enables autoscrolling to the end of graph on draw  

infoView = UIView // This can override default infoView. You can just ignore it, or set to nil to use default infoView

backgroundColor  = UIColor // background color

spaceBetweenPoints = Int // this is space beetween two point on xAxis

animation = Bool //ebale or disable graph draw animation

animationTime = Int // time, which graph animation will take (see )

leftSpacer = Int // left safe space, so you can scroll to the first point

rightSpacer = Int // right safe space, so you can scroll to the last point

chartLine.color = UIColor // chartline color

chartLine.size = Int // charline size

pickedPoint.size = Int // current "picked" point size. Set to 0, not to show it

pickedPoint.color = UIcolor // current "picked" point color

points.size = Int // all graph points size. Set to 0, not to show them

points.color = UIColor // graph points color

xAxisLine.isOn = Bool // show or not xAxis Line

xAxisLine.size = 1 // xAxis line size 

xAxisLine.color = UIColor // xAxis line color

yAxisLine.isOn = Bool // show or not yAxis Line

yAxisLine.size = 1 // yAxis line size 

yAxisLine.color = UIColor // xAxis line color




