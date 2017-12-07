String[] names;
int[] values;
int max;
int length;
float top, bottom, left, right, chartWidth, chartHeight;

void setup() {
  size(600, 800);
  surface.setResizable(true);
  parse();
  length = values.length;
  setMax(values);
}

void draw() {
  textFont(createFont("Arial", height / 60 + 4, true));
  background(255);
  updateDimensions();
  drawValues();
  drawBars();
  stroke(150);
  line(left, top, left, bottom);
  line(left, bottom, right, bottom);
  textAlign(CENTER);
  text("Values", left / 2, (top + chartHeight) / 2);
  text("Names", left + chartWidth / 2, bottom + (height - bottom) * 0.7);
  drawLabel();
}

void parse() {
   String[] lines = loadStrings("./data.csv");
   //String[] headers = split(lines[0], ",");
   //names = new String[lines.length - 1];
   //values = new int[lines.length - 1];
   for(int i = 1; i < lines.length; i++){
     String[] data = split(lines[i], ",");
     employees[i - 1] = new Employee(
     names[i - 1] = data[0];
     values[i - 1] = int(data[1]);
   }
   printArray(headers);
   printArray(names);
   printArray(values);
}

void setMax(int[] nums) {
  max = 0;
  for (int i = 0; i < length; i++) {
    if (nums[i] > max) {
      max = nums[i];
    }
  }
  //return max;
}

void drawBars() {
  for (int i = 0; i < length; i++) {
    float x = left + (chartWidth * i / length);
    float y = bottom;
    float w = (chartWidth / length) / 2;
    float h = values[i] * -chartHeight / max;
    color c = color(0, 100, 200);
    if (mouseX >= x && mouseX <= x + w &&
        mouseY <= y && mouseY >= bottom + h) {
        c = color(255, 0, 0);
    }
    fill(c);
    rect(x, y, w, h);
    pushMatrix();
    translate(x + w / 2, bottom + 5);
    textAlign(RIGHT);
    rotate(3 * HALF_PI);
    translate(-(x + w / 2), -bottom - 5);
    text(names[i], x + w / 2, bottom + 5);
    popMatrix();
  }
}

void drawLabel() {
  for (int i = 0; i < length; i++) {
    float x = left + (chartWidth * i / length);
    float y = bottom;
    float w = (chartWidth / length) / 2;
    float h = values[i] * -chartHeight / max;
    if (mouseX >= x && mouseX <= x + w &&
        mouseY <= y && mouseY >= bottom + h) {
        fill(255);
        rect(mouseX, mouseY, height / 5 + 30, 20);
        fill(0);
        textAlign(LEFT);
        text("(" + names[i] + ", " + String.valueOf(values[i]) + ")", mouseX + 10, mouseY + 15);
    }
  }
}

void drawValues() {
  fill(color(0, 100, 200));
  for (int i = 0; i <= max / 10; i++) {
    float numHeight = bottom - i * chartHeight * 10 / (max * 1.0);
    line(left, numHeight, right, numHeight);
    textAlign(RIGHT);
    text(String.valueOf(i * 10), left - 5, numHeight + 3);
  };
}


void updateDimensions() {
  top = height * 0.1;
  bottom = height * 0.7;
  left = width * 0.2;
  right = width * 0.9;
  chartWidth = width * 0.7;
  chartHeight = height * 0.6;
}