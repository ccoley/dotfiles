/*
 *  Accepts strings over {a,b} that contain either the substring aabb, or the
 *  substring bbab, or the substring ababab.
 *  
 *  Chris Coley, 9/6/11
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class FiniteStateMachine {
	private final static int[][] STATE_TABLE = {
        {  1,  3,  8 },         // State 0 (Start)
        {  4,  2,  8 },         // State 1
        {  3,  5,  8 },         // State 2
        {  1,  5,  8 },         // State 3
        {  4,  6,  8 },         // State 4
        {  6,  5,  8 },         // State 5
        {  4,  7,  8 },         // State 6
        {  7,  7,  8 },         // State 7 (Accept)
        {  8,  8,  8 },         // State 8 (Trap)
	};
	
	private BufferedReader in;
	
	public FiniteStateMachine() {
		in = new BufferedReader(new InputStreamReader(System.in));
	}
	
	public void run() throws IOException {
		char ch;
		int	state;
		
		for(;;) {
			System.out.print("Enter your string: ");
			ch = (char) in.read();
			state = 0;
			
			while(ch != '\n') {
				state = STATE_TABLE[state][charToColumn(ch)];
				ch = (char) in.read();
			}
			
			if(state == 7) {
				System.out.println("Accept\n");
			} else {
				System.out.println("Reject\n");
			}
		}
	}
	
	public int charToColumn(char ch) {
		int column = 2;
		
		switch(ch) {
		case 'a':
			column = 0;
			break;
		case 'b':
			column = 1;
			break;
		}
		
		return column;
	}
	
	public static void main(String[] args) {
		try {
			FiniteStateMachine fsm = new FiniteStateMachine();
			fsm.run();
		} catch (IOException ex) {
			ex.printStackTrace();
			System.exit(1);
		}
	}
}
