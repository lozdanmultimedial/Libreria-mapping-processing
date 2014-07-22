// autor Lozdan Claudio  Junio del 2014
// utilizado para el festival FISOL 2014 en la Facultad de Informática de la UNLP
// comisinado por la agrupación "La Fuente" conducción del CEFI
// Gracias LA Fuente.

//1) flores
//2) concentricos = circulos concentricos conel centro
//3) casi fractal
//4) circulos girando
//5) curvas finas y circulos bailando
//6) curvas con relleno

// instrucciones: para comenzar a calibrar presionar 'c' para finalizar la calibración volver a presionar 'c'
// las visuales se activan presionando las teclas ' 1 a la 0 y q hasta la t '
// la variable cantidad determina el numero de superficies disponibles, puede ser editada por el usuario.


import processing.opengl.*;
import codeanticode.glgraphics.*;
import deadpixel.keystone.*;

import krister.Ess.*;//FFT

int estado;
GLGraphicsOffScreen of[] ;
Keystone ks;
CornerPinSurface sup[];


FFT myfft;
AudioInput myinput;
int bufferSize = 512;

int cantidadsuperficies = 15; 
int w = 900; int h = 600;
float l,l2,r,g,b,a, x1,y1,x2,y2,x3,y3, x4, y4,k;
float xx = 20, yy = 10, xx2 = 90, yy2 = 50, xx3 = 160, yy3 = 70,xx4 = 230, yy4 = 90;
float nivel, ang = 0;  float cx,cy, rd = 20;
int  cant = 20, cantidad = 10;
int cont = 0;
float d = w, dd = 0;;// para el estado = 14 y caso r

Caminante[] pepe; color [] pintura;//para caso"w" estado = 11

void setup() 
{
  size(w,h,GLConstants.GLGRAPHICS);
  frameRate(30);
  ks = new Keystone (this);
  of = new GLGraphicsOffScreen [ cantidadsuperficies ];
  sup = new CornerPinSurface [ cantidadsuperficies ];
 for( int i = 0; i < cantidadsuperficies; i++)
  {
    of[i] = new GLGraphicsOffScreen(this, width, height);
   
    sup[i] = ks.createCornerPinSurface(width, height, 10);
    
  }
  
   iniciarFFT();
   iniciarPepe();
   
 
}//  end setup

void draw()
{
  
  background(000);
  
  for (int i = 1; i < bufferSize - 1; i = i + bufferSize/5)
  {
    calculos(i);
   
    for( int j = 0; j < cantidadsuperficies; j++)
    {
      float k = 0;
      
        int q;
        q = (estado == 6?  10 :  5 );
      
        for( int z  = 0; z < q ; z++)
        {
       
        calculos(z);
     
        if( estado != 3 )
        {
           acotar();
        }// if estado != 3
      
       if( estado == 1 )
       {
          flores(j);
       }
       else if ( estado == 2)
       {
         concentricos(k,j);
       }
       else if ( estado == 3 || estado == 4)
       {
         if (estado == 3)
         {
           for( int g = 0; g < 5; g++)
           {
             fractal(j);
             calculos(g);
           }
         }
         else { fractal(j); }
       }// end estado 3
       if( estado == 5)
       {
         curvas2(j);
       }
       if ( estado == 6 )
       {
         curvas(j);
       }
       if ( estado == 7 )
       {
         espiral(i,j); // circulos girando en espiral
       }
       if ( estado == 8)
      {
        circulos(i,j); // circulos en diagonal
      } 
        
       if ( estado == 9)
       {
         faro(j);
       }
       if ( estado == 10 )// escocesa
       {
         entramar(j);
       }
       if ( estado == 11 )// lineaslocas
       {
         lineasLocas(j);
       }
       if ( estado == 12)// solgirar
       {
         solgirar(j);
       }
       if(estado == 13)// pulsar case "0"
       {
         pulsar(j);
       }
       if(estado == 14)// flecha hacia la izq
       {
         flecha(j);
       }
       if( estado == 15) //flechas ida y vuelta
       {
         flechasIdaVuelta(j);
       }
       if( estado == 17 )//arcoiris
       {
       } 
       }//z
      if( estado == 2 ) { k = k + 5; }// concentricos
    }//j
    
   }// end for i < buffersize
 
  for( int j = 0; j < cantidadsuperficies; j++)
  {
      sup[j].render(of[j].getTexture());
  }
  
  if( estado != 12)
  {
     limpiarpantalla();
  }
}// end draw ////////////////////


void limpiarpantalla()
{
  for( int i  = 0; i < cantidadsuperficies; i++)
  {
    of[i].beginDraw();
       of[i].background(0);
  of[i].endDraw();
  }
}
 
void iniciarPepe()
{
  pepe = new Caminante[cant];
  pintura = new color[cant];
  
  for( int i = 0; i < cant; i++)
  {
    pepe[i] = new Caminante();

  }
}// end iniciarPepe


/////////////////////////////////////////////////////////////// AUDIO 

public void audioInputData(AudioInput theInput)
{
  myfft.getSpectrum(myinput);
}

void iniciarFFT()
{
  Ess.start(this);
  myinput=new AudioInput(bufferSize);
  myfft=new FFT(bufferSize*2);
  myinput.start();

  myfft.damp(.3);
  
  myfft.equalizer(true);
  myfft.limits(.005,.05);
}

//////////////////////////////////////////////////////// calculos
void calculos(int i1)
{
    nivel = myfft.spectrum[i1]*100;
    //println("    NV =  "+nivel);
    if( estado == 5 ) { l = myfft.spectrum[i1]*500; }
    int i2 = i1++;
    if( i2 > bufferSize -1 ) { i2 = i2 - bufferSize; }
    if(i1%2 == 0 )
         
            { x2 = w/2 * cos( myfft.spectrum[i2]*1000);}
            else
            { x2 = w/2 * cos( myfft.spectrum[i2]*-1000);} 
     
    int i3 = i1+2;
    if( i3 > bufferSize -1 ) { i3 = i3 - bufferSize; }
    if(i1%2 == 0 && estado != 10)
          {y2 = h/2 * sin(myfft.spectrum[i3]*1000);}
          else if ( estado != 10)
          {y2 = h/2 * sin(myfft.spectrum[i3]*-1000);}
         
    
    int i4 = i1+2;
    if( i4 > bufferSize -1 ) { i4 = i4 - bufferSize; }
    a = myfft.spectrum[i4]*500;
    
         int i5 = i4 ++;
         if( i5> bufferSize -1 ) { i5 = i5 - bufferSize; }
         if(i1%2 == 0 && estado == 5 )
         
            { x1 = w/2 * cos( myfft.spectrum[i5]*1000);}
            else
            { x1 = w/2 * cos( myfft.spectrum[i5]*-1000);}
         
         int i6 = i5+1;
         if( i6> bufferSize -1 ) { i6 = i6 - bufferSize; }
         
         if(i1%2 == 0 && estado == 5)
          {y1 = h/2 * sin(myfft.spectrum[i6]*1000);}
          else
          {y1 = h/2 * sin(myfft.spectrum[i6]*-1000);}
         
         
         int i7 = i6 +1;
         if( i7> bufferSize -1 ) { i7 = i7 - bufferSize; }
         
         if(i1%2 == 0 )
         
            { x3 = w/2 * cos( myfft.spectrum[i7]*1000);}
            else
            { x3 = w/2 * cos( myfft.spectrum[i7]*-1000);}
         int i8 = i7+1;
         if( i8> bufferSize -1 ) { i8 = i8 - bufferSize; }
         
         if(i1%2 == 0 )
          {y3 = h/2 * sin(myfft.spectrum[i6]*1000);}
          else
          {y3 = h/2 * sin(myfft.spectrum[i6]*-1000);}
         
         int i9 = i8 +1;
         if( i9> bufferSize -1 ) { i9 = i9 - bufferSize; }
         
         if(i1%2 == 0 )
         
            { x4 = w/2 * cos( myfft.spectrum[i9]*1000);}
            else
            { x4 = w/2 * cos( myfft.spectrum[i9]*-1000);}
            
         int i10 = i9+1;
         if( i10> bufferSize -1 ) { i10 = i10 - bufferSize; }
         
         if(i1%2 == 0 )
          {y4 = h/2 * sin(myfft.spectrum[i10]*1000);}
          else
          {y4 = h/2 * sin(myfft.spectrum[i10]*-1000);}
          if (estado != 3 ) { l = myfft.spectrum[i10]*500; } 
    
              // y = myfft.spectrum[i]*-5;
    //println(" l = "+l);
          
         if( estado == 3 || estado == 4)
        {
          
          if(i1 > bufferSize - 1) { i1 = bufferSize -i1; }
          
            l = myfft.spectrum[i1]* 100;
            x1 =  w/2 + l * cos(ang) *2 ;
            
            y1 = h/2 + l * sin(ang)*2;
            if  (estado == 3 ) { ang= ang + 0.03;}
            else { ang =  ang + 0.3;}
            if( ang > 360 ) { ang = 360 -ang; }
            
            if( x1 > width -l ) { x1 = width - x1 -l; }
            if( x1 < l ) { x1 = x1 + width + l; }
            if( y1 > height -l ) { y1 = height - y1 - l; }
            if( y1 < l ) { y1 = y1 + height + l; }
        
        }// end of estado == 3
         
         if( estado == 3)// fractal
         {
           r = constrain(myfft.spectrum[i5]*500,0,180) ;
           g = constrain(myfft.spectrum[i6]*500,0,180) ;
           b = constrain(myfft.spectrum[i7]*500,0,180) ; 
         }
         else
         {
           r = myfft.spectrum[i5]*500 ;
           g = myfft.spectrum[i6]*500;
           b = myfft.spectrum[i7]*500; 
         }
          if( estado == 9 )
          {
            l = myfft.spectrum[i10]*500;  
          }
          if( estado == 10 )
          {
            l = myfft.spectrum[i1]*-500;
          
            x2 = myfft.spectrum[i5]*500;     
            y2 = myfft.spectrum[i6]*500;
            l2 = myfft.spectrum[i7]*500;
          
          }

}// end calculos

void acotar()
{
           x1 = ( x1 > width ?  x1 - width : x1 );
           x1 = (x1 <0 ? x1 + width : x1 );
           y1 = ( y1 > height  ? y1-height : y1 );
           y1 = ( y1 < 0 ? y1 + height  : y1 );
           
           x2 = ( x2 > width ?  x2 - width : x2 );
           x2 = (x2 < 0 ? x2 + width: x2 );
           y2 = ( y2 > height  ? y2-height : y2 );
           y2 = ( y2 < 0 ? y2 + height  : y2 );
           
           x3 = ( x3 > width ?  x3 - width : x3 );
           x3 = (x3 < 0 ? x3 + width: x3 );
           y3 = ( y3 > height  ? y3-height : y3 );
           y3 = ( y3 < 0 ? y3 + height  : y3 );
           
           x4 = ( x4 > width ?  x4 - width : x4 );
           x4 = (x4 < 0 ? x4 + width: x4 );
           y4 = ( y4 > height  ? y4-height : y4 );
           y4 = ( y4 < 0 ? y4 + height  : y4 );
}

///////////////////////////////////////// clase caminante

class Caminante
{
  
  float x,y, variacion;
  float vel, dir,dx,dy, angulo;
  int d;
  
  Caminante()
  {
    x = random( width );
    y = random( height );
    vel = 4;
    dir = random( TWO_PI );
    d = int( random(15,35));
    variacion = radians( 3 );
  }// end constructor
  
  
  void perseguir( int yo, int tu)
  {
      angulo = atan2(pepe[tu].y - pepe[yo].y, pepe[yo].x - pepe[yo].x);
      float me_apuro = random(2,5);
      
      dx = (vel ) * cos(angulo)+ variacion;
      dy = (vel ) * sin(angulo) + variacion;

  }////////////////////
  
  void huir ( int yo, int tu)
  {
    float angulo = atan2(pepe[tu].y - pepe[yo].y, pepe[yo].x - pepe[yo].x);
    dx = vel  * cos(angulo) + variacion + PI;
    dy = vel  * sin(angulo) + variacion + PI;
  }////////////////
  
  void mover(int yo, float r, float g, float b, float a)
  {
    
    variacion = radians( random(-10,10) );
    
    dir += variacion;
    int tu = (yo + 1)% cant;
     if (  dist( pepe[yo].x, pepe[yo].y, pepe[tu].x, pepe[tu].y ) >= 20 * d +a )
    {
      perseguir( yo, tu );
      stroke(r,g,b,a);
      strokeWeight(a/20);
    }
    if (  dist( pepe[yo].x, pepe[yo].y, pepe[tu].x, pepe[tu].y ) <= d * 3 -a )
    {
      huir( yo,tu);
      
    }
   
      x += dx;
      y += dy + a/20;
      
    x = (x > width ? x-width : x );
    x = (x < 0 ? x+width : x );
    y = (y > height ? y-height : y );
    y = (y < 0 ? y+height : y );
    
    line(pepe[yo].x, pepe[yo].y, pepe[tu].x, pepe[tu].y );
  }// end mover
  
}// end class

/////////////////////////////////////////////////////////// coordenadas
void iniciarcoordenadas(int i)
{
  if( estado == 7)
  {
    x1 = width/2; 
    y1 = height/2; 
    cx = x1;   cy = y1;
  }
  else if ( estado == 8 )
  {
    x1 =  map( myfft.spectrum[i]*100,0,40,0,width);
      if ( i  + 1 > bufferSize - 1 ) { i = 0; }
      y1 = map( myfft.spectrum[i]*100,0,40,0,height);
      
      int i2 = i++;
      if( i2 > bufferSize -1 ) { i2 = i2 - bufferSize; }
      x2 = map( myfft.spectrum[i2]*100,0,40,0,width);
      int i3 = i+2;
      if( i3 > bufferSize -1 ) { i3 = i3 - bufferSize; }
      y2 = map( myfft.spectrum[i3]*100,0,40,0,height);
    }// end else if
    
    if ( estado == 10)
    {
       x1 = width/5;  y1 = height/5;
       x2 = width - x1; y2 = height - y1;
    }
  }// end iniciar coordenadas
  
  ///////////////////////////////////////////////////////////// teclas
  
  void keyPressed() 
{

  switch(key) 
  {
  case 'c':
    ks.toggleCalibration();
  break;
  case 'l':
    ks.load();
    break;
  case 's':
    ks.save();
  break;
  case '1':
    estado = 1;// flores
  break;
  case '2':
    estado = 2;// concentricos
  break;
  case '3':
    estado = 3;// fractal
  break;
  case '4':
    estado = 4;// fractal variante del anterior
  break;
  case '5':
   estado = 5;// curvas2
   break;
   case '6':
   estado = 6;// curvas
   break;
   case '7':
   estado = 7;// espiral
   break;
   case '8':
   estado = 8;// circulos en diagonal
   break;
  case '9':
   estado = 9;// lineas central
   break;
   case '0':
   estado = 13;
   break;
   case 'q':
   estado = 10;// escocesa
   break;
   case 'w':
   estado = 11;// lineasLocas
   break;
   case 'e':
   estado = 12;//solgirar
   break;
   case  'r':// flecha
   estado = 14;
   break;
   case 't':// flechasIdaVuelta
   estado = 15;
   break;
   case 'u':
   estado = 16;// do it
   break;
   case 'i':
   estado =  17;// circulo
   break;
   
  }// end switch
}///////////////////////////////////////////////////////////// visuales

void flechasIdaVuelta(int j )// caso 't'
{
  of[j].beginDraw();
          
         
          of[j].strokeWeight(l/30);
          of[j].stroke(r,g,b,a);
          
            of[j].line(d,0,d - 200,h/2);
            of[j].line(d,h ,d - 200,h/2);
            
            of[j].line(dd, 0, dd + 200, h/2);
            of[j].line(dd, h  , dd + 200, h/2);
            //////////////////////////////////////////
            of[j].line(d - 200,0,d - 500,h/2);
            of[j].line(d - 200,h ,d - 500,h/2);
            
            of[j].line(dd + 200, 0, dd + 500, h/2);
            of[j].line(dd + 200, h  , dd + 500, h/2);
            //////////////////////////////////////////
            
            of[j].line(d - 400,0,d - 700,h/2);
            of[j].line(d - 400,h ,d - 700,h/2);
            
            of[j].line(dd + 400, 0, dd + 700, h/2);
            of[j].line(dd + 400, h  , dd + 700, h/2);
            //////////////////////////////////////////
          
            of[j].line(d - 600,0,d - 1000,h/2);
            of[j].line(d - 600,h ,d - 1000,h/2);
            
            of[j].line(dd + 600, 0, dd + 1000, h/2);
            of[j].line(dd + 600, h  , dd + 1000, h/2);
            //////////////////////////////////////////
            
        of[j].endDraw();
        d -= 0.3; dd += 0.3;
        if( d < 0 ){ d = w; }
        if( dd > w ) { dd = 0;}
}

void flecha( int j)// caso 'r'
{  
  of[j].beginDraw();
          
         
          of[j].strokeWeight(l/30);
          of[j].stroke(r,g,b,a);
          
            of[j].line(d,h/4,d - 100,h/2);
            of[j].line(d,h * 3/4,d - 100,h/2);
            
            of[j].line(d - 200,h/4,d - 300,h/2);
            of[j].line(d - 200,h * 3 /4,d - 300,h/2);
            
             of[j].line(d - 400,h/4,d - 500,h/2);
            of[j].line(d - 400,h * 3 /4,d - 500,h/2);
          
        of[j].endDraw();
        d -= 0.3;
        if( d < 0 ){ d = w; } 
}// end flecha

void pulsar ( int j)
{
  float r = l;
       
        of[j].beginDraw();
          of[j].smooth();
          of[j].noFill();
          of[j].strokeWeight(l);
          for( int c = 1; c < 3; c++)
          { 
            if( c%2 != 0 ){ of[j].stroke(255);}
            else { of[j].stroke(0);}
            of[j].ellipse(w/2,h/2,r,r);
            r = l * c/2;
          }
          
        of[j].endDraw();
}// end pulsar estado 13 case "0"

void solgirar(int j)
{
  of[j].beginDraw();
        of[j].noStroke();
          of[j].fill(0,5);
          of[j].rect(0,0,w,h);
          of[j].fill(r,g,b,a);

          of[j].ellipse(w/2,h/2,l/5,l/5);
          
          of[j].ellipse(xx + 20,yy + 20,l/20,l/20);
          of[j].fill(g,b,r,a);
          
          of[j].ellipse(xx2,yy2,l/20,l/20);
          of[j].fill(b,r,g,a);
          
          of[j].ellipse(xx3,yy3,l/20,l/20);
          of[j].fill(a,b,r,g);
          of[j].ellipse(xx4,yy4,l/20,l/20);
          
          
          of[j].strokeWeight(l/300);
          of[j].stroke(r,g,b,a);
          of[j].line(xx + 20, yy+20,w/2,h/2);
          of[j].stroke(g,b,r,a);
          of[j].line(xx2, yy2,w/2,h/2);
          of[j].stroke(b,r,g,a);
          of[j].line(xx3, yy3,w/2,h/2);
          of[j].stroke(a,b,r,g);
          of[j].line(xx4, yy4,w/2,h/2); 
        of[j].endDraw();
       
       if (xx < w - 20 && yy <= 10 ) {xx+= 0.56;}
      if(xx >= w - 40 && yy < h - 40){yy+= 0.56;}
      if( xx > 10 && yy >= h -40) {xx-= 0.56;}
      if( xx <= 10 && yy >= 10) {yy-= 0.56;}
       
       if (xx2 < w - 40 && yy2 <= 60 ) {xx2+= 0.5;}
      if(xx2 >= w - 60 && yy2 < h - 60){yy2+= 0.5;}
      if( xx2 > 40 && yy2 >= h -60) {xx2-= 0.5;}
      if( xx2 <= 60 && yy2 >= 60) {yy2-= 0.5;}
      
       if (xx3 < w - 90 && yy3 <= 90 ) {xx3+= 0.45;}
      if(xx3 >= w - 90 && yy3 < h - 90){yy3+= 0.45;}
      if( xx3 > 90 && yy3 >= h -90) {xx3-= 0.45;}
      if( xx3 <= 90 && yy3 >= 90) {yy3-= 0.45;}
       
      if (xx4 < w - 120 && yy4 <= 120 ) {xx4+= 0.4;}
      if(xx4 >= w - 120 && yy4 < h - 120){yy4+= 0.4;}
      if(xx4 > 120 && yy4 >= h -120) {xx4-= 0.4;}
      if( xx4 <= 120 && yy4 >= 120) {yy4-= 0.4;}
}// end solgirar estado = 12 caso "E"

void lineasLocas(int j)
{
  of[j].beginDraw();
          
         
          for( int q = 0; q < cant; q++)
           {
             pepe[q].mover(q,r,g,b,a);
            
           }
        of[j].endDraw();
}// end lineas locas estado  = 11 caso W

void entramar(int j)// escocesa estado 10 caso "q"
{
  of[j].beginDraw();
                 float xx = 0;   float yy = 0; 
                 
                 //iniciarcoordenadas(1);
                 for( int z = 0; z < 10; z ++)
                 {
                  calculos(z);
                     
                     of[j].strokeWeight(l*-1000);
                     
                     for( float p = 0; p < w/80; p = p+20)
                     {
                       of[j].stroke(r,g,b,a);
                       for( int k = 9; k >0; k = k - 2)
                       {
                         of[j].line(0,yy + h* k/10,w,yy + h* k/10);
                       }
                       
                       
                       yy = yy+13;
                       
                       for( int k = 9; k > 0; k = k -2)
                       {
                         of[j].line(xx + w *k/10 ,0,xx + w *k/10 ,h);
                       }
                       
                       
                       xx = xx + 11;
                      
                     }//p
                       
                  }// z
            
    of[j].endDraw();
}// end escocesa estado 10 caso q

float c = 0;
void faro( int j) // estado 9
{
  of[j].beginDraw();
        //of[j].fill(0,15);
        //of[j].rect(0,0,w,h);
          of[j].translate(w/2,h/2);
          of[j].rotate(c);
          of[j].stroke(r,g,b,nivel * 8);
          of[j].strokeWeight(1);
          of[j].line(0,0,x1, y1); 
          of[j].line(0,0,x2, y2);
          of[j].line(0,0,x3, y3);
          of[j].line(0,0,x4, y4);
          of[j].noStroke();
          float ll = map(l,20,200,7,20);
          of[j].fill(r,g,b,nivel * 4 );
          of[j].ellipse(x1, y1,ll,ll);
          of[j].ellipse(x2, y2,ll,ll);
          of[j].ellipse(x3, y3,ll,ll);
          of[j].ellipse(x4, y4,ll,ll); 
          of[j].ellipse(x4 * cos(c), y4 * sin(c),ll/4,ll/4); 
          of[j].stroke(r,g,b,nivel * 8);
          of[j].strokeWeight(l);
          of[j].ellipse(x1 * cos(c), y1 * sin(c),ll/2,ll/2);
          
       of[j].endDraw();
       c = c + .5;
}// end lineas central


void circulos ( int i, int j)// estado 8
{
   of[j].beginDraw();
                 
                 iniciarcoordenadas (i); 
                  for( int z = 0; z < cantidad; z = z +2)
                 {
                   of[j].noStroke();     of[j].smooth();
                   of[j].fill(r,g,b,a);  
                   of[j].ellipse(x1,y1,l,l);
                   y1 = y1+40 +y2; x1 = x1 +40+x2;
                     
                  }
            
    of[j].endDraw();
}// end circulos estado 8

void espiral( int bf, int z)
{
  of[z].beginDraw();
  
      of[z].noStroke();           
      iniciarcoordenadas (bf); 
      rd = k + map( myfft.spectrum[bf] * 100, 0,90,0,width/10);
      
      for( int j = 0; j < 20; j++)
      {
            x2 =  cx + rd * cos(ang)  ;
            int i1 = bf++;
            if ( i1 > bufferSize -1 ){ i1 = bufferSize - i1; }
            y2 = cy + rd * sin(ang);
            ang= ang + 0.3;
            if( ang > 360 ) { ang = 360 -ang; }
            
            of[z].fill(r,g,b);
           
            if( bf > bufferSize -1) { bf = bufferSize - bf;}
            l = map( myfft.spectrum[bf] * 100, 0,90,0,width/10);
            of[z].ellipse(x2,y2,l,l);
            rd = rd + 20;
      }
                  
    of[z].endDraw();
}// end esiral estado 7

void curvas( int j)// estado == 6
{
  of[j].beginDraw();
          
          l = l/10;
          of[j].noStroke();
          of[j].fill(r,g,b,a);
          of[j].ellipse(x1,y1,l,l);
          of[j].ellipse(x2 ,y2,l,l );
          of[j].ellipse(x3 ,y3,l,l );
         
          of[j].bezier(x1,y1,x2,y2,x3,y3,x4,y4);
          
        of[j].endDraw();
}// end curvas, estado = 6

void fractal(int j)
{
  
  of[j].beginDraw();
         
         of[j].noStroke();
         of[j].fill(r,g,b,a);
         of[j].ellipse(x1,y1,l * 5,l * 5);
   of[j].endDraw();
     
}
void concentricos(float k,int j)
{
  of[j].beginDraw();
          of[j].strokeWeight(l); 
          of[j].noFill();
          of[j].stroke(r,g,b,a * 2);
          of[j].ellipse(w/2 + k,h/2 + k ,l  *2+ k,l  *2 + k);
          
        of[j].endDraw();
}
void flores(int j)
{
  of[j].beginDraw();
          
          of[j].fill(r,g,b,a);
          of[j].ellipse(x1,y1,l/3,l/3);
          of[j].ellipse(x2 ,y2,l/3,l/3 );
          of[j].ellipse(x3 ,y3,l/3,l/3 );
          of[j].stroke(b,r,g);
          of[j].strokeWeight(l/20);
        of[j].endDraw();
}

void curvas2( int j)
{
  // estado = 5
  of[j].beginDraw();
          
          l = l/10;
          of[j].noStroke();
          of[j].fill(r,g,b,a);
          of[j].ellipse(x1,y1,l,l);
          of[j].ellipse(x2 ,y2,l,l );
          of[j].ellipse(x3 ,y3,l,l );
          of[j].stroke(b,r,g);
          of[j].noFill();
         
          of[j].bezier(x1,y1,x2,y2,x3,y3,x4,y4);
         
        of[j].endDraw();
}
///////////////////////////////////////////////////////////// FIN
  /////////////////////////////////////////////////////////////////////////////////
