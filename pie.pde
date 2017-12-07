color blue = color(0, 150, 200);
color lightBlue = color(0, 200, 255);

public class Pie {
  String names[];
  int values[];
  int total;
  boolean isPie;
  float r;
  float donutR;
  
  Pie() {
    parse();
    setTotal();
    isPie = true;
    r = min(width, height) * 0.4;
    donutR = 0;
    textFont(createFont("Arial", height / 60 + 4, true));
  }
  
  void parse() {
    String[] lines = loadStrings("./data.csv");
    String[] headers = split(lines[0], ",");
    this.names = new String[lines.length - 1];
    this.values = new int[lines.length - 1];
    for(int i = 1; i < lines.length; i++){
      String[] data = split(lines[i], ",");
      names[i - 1] = data[0];
      values[i - 1] = int(data[1]);
    }
  }
  
  void setTotal() {
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
  }
  
  void toggleState() {
   isPie = !isPie;
   if (donutR == 0) {
     donutR = min(width, height) * 0.3;
   } else {
     donutR = 0;
   }
  }
  
  void drawChart() {
    r = min(width, height) * 0.4;
    if (!isPie) {
      donutR = min(width, height) * 0.3;
    }
    float start = 0;
    float end;
    stroke(255);
    strokeWeight(3);
    for (int i = 0; i < values.length; i++) {
      end = start + values[i] * 2 * PI / this.total;
      if (highlight(start, end)) {
        drawLabel(i);
        fill(lightBlue);
      } else {
        fill(blue);
      }
      arc(width / 2, height / 2,
      r * 2,
      r * 2,
      start,
      end, PIE);
      start = end;
    }
    if (!isPie) {
      fill(50);
      ellipse(width / 2,
              height / 2,
              donutR,
              donutR);
    }
  }
  
  int quadrant() {
    float centerX =  width / 2;
    float centerY = height /2;
    if(mouseX > centerX && mouseY < centerY) {
       return 4; 
    } else if(mouseX < centerX && mouseY < centerY) {
      return 3;
    } else if(mouseX < centerX && mouseY > centerY) {
      return 2;
    } else {
      return 1;
    }
  }
  
  boolean highlight(float start, float end) {
    float angle;
    
    float opposite = abs(mouseY - (height / 2));
    float hypotenuse = dist(mouseX, mouseY, width / 2, height / 2);
    angle = asin(opposite / hypotenuse);
    
    //if quad 1, angle doesnt need to change
    if(quadrant() == 2) {
       angle = PI - angle;
    } else if(quadrant() == 3) {
       angle = PI + angle;
    } else if(quadrant() == 4) {
       angle = 2*PI - angle;
    }
    
    
    return hypotenuse <= r &&
           hypotenuse >= donutR / 2 &&
           start < angle &&
           angle < end;
  }
  
  void drawLabel(int i) {
    String label = names[i] + ", " + String.valueOf(values[i]);
    fill(255);
    textAlign(CENTER);
    text(label, width / 2, height * 0.95);
  }
  
}