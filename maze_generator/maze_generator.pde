//uses depth-first-search algorithm

//width and height of a cell in pixels
final int cellsize = 10;
//width of the maze in cells
final int mw = 20;
//height of the maze in cells
final int mh = 20;
//seed used to generate the maze
final int seed = 29;
Cell[][] maze = new Cell[mw][mh];
ArrayList<Cell> stack = new ArrayList<Cell>(0);
void setup() {
  strokeWeight(1);
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      maze[x][y] = new Cell(x, y);
    }
  } 
  randomSeed(seed);
  size(250, 250);
  stack.add(maze[floor(random(0, mw))][floor(random(0, mh))]);
  stack.get(0).visited=true;
}
Cell curr;
void draw() {
  for (int i = 0; i < 10; i++) {
    if (stack.size()>0) {
      curr = stack.get(stack.size()-1);
      //boolean dead = true;
      Cell[] unvisited = new Cell[4];
      int next = 0;
      if (curr.x < mw-1) {
        //dead = maze[curr.x+1][curr.y].visited&&dead;
        if (!maze[curr.x+1][curr.y].visited) {
          unvisited[next] = maze[curr.x+1][curr.y];
          next++;
        }
      }
      if (curr.x > 0) {
        //dead = maze[curr.x-1][curr.y].visited&&dead;
        if (!maze[curr.x-1][curr.y].visited) {
          unvisited[next] = maze[curr.x-1][curr.y];
          next++;
        }
      } 
      if (curr.y < mh-1) {
        //dead = maze[curr.x][curr.y+1].visited&&dead;
        if (!maze[curr.x][curr.y+1].visited) {
          unvisited[next] = maze[curr.x][curr.y+1];
          next++;
        }
      }
      if (curr.y > 0) {
        //dead = maze[curr.x][curr.y-1].visited&&dead;
        if (!maze[curr.x][curr.y-1].visited) {
          unvisited[next] = maze[curr.x][curr.y-1];
          next++;
        }
      } 
      if (next == 0) {
        stack.remove(stack.size()-1);
      } else {
        Cell pcurr = unvisited[floor(random(0, next))];
        pcurr.visited = true;
        stack.add(pcurr);
        if (pcurr.x != curr.x) {
          if (pcurr.x - curr.x == 1) {
            curr.directions[0] = true;
          } else {
            pcurr.directions[0] = true;
          }
        }
        if (pcurr.y != curr.y) {
          if (pcurr.y - curr.y == 1) {
            curr.directions[1] = true;
          } else {
            pcurr.directions[1] = true;
          }
        }
      }
    }
  }
  display();
  if (stack.size() == 0) {
    //saveFrame("maze-w"+mw+"h"+mh+"s"+seed);
    noLoop();
  }
}
void display() {
  translate(floor((width-(mw*cellsize))/2.0),floor((height-(mh*cellsize))/2.0));
  background(255);
  noStroke();
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      if (maze[x][y].visited == false) {
        fill(0);
        square(x*cellsize, y*cellsize, cellsize);
      } else {

        fill(255);
        square(x*cellsize, y*cellsize, cellsize);
      }
    }
  }
  stroke(0);
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      if (maze[x][y].visited) {
        if (!maze[x][y].directions[0]) {
          //print("hello");
          line(x*cellsize+cellsize, y*cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
        }
        if (!maze[x][y].directions[1]) {
          line(x*cellsize, y*cellsize+cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
        }
      }
    }
  }
  noFill();
  rect(0, 0, mw*cellsize, mh*cellsize);
}
