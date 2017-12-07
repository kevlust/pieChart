String[] names;
int[] values;
int total = 0;
Pie chart;

void setup() {
  size(800, 600);
  background(50);
  chart = new Pie();
}

void draw() {
  fill(255);
  background(50);
  ellipse(width * 0.1, width * 0.1, width * 0.1, width * 0.1);
  if (chart.isPie) {
    fill(50);
    ellipse(width * 0.1, width * 0.1, width * 0.05, width * 0.05);
  }
  chart.drawChart();
}

void mouseClicked() {
  
  if (dist(mouseX, mouseY, width * 0.1, width * 0.1) < width * 0.05) {
    chart.toggleState();
  }
}