# -*- coding: utf-8 -*-

#Copy gate:
import numpy as np
def J_COPY(size,input1,output1):
    blank = np.zeros((size,size))
    blank[input1,output1] = blank[output1,input1] = 1
    return blank
def h_COPY(size,input1,output1):
    blank = np.zeros(size)
    blank[input1]=blank[output1]=0
    return blank
#AND gate:
def J_AND(size,input1,input2,output):
    blank = np.zeros((size,size))
    blank[input1,input2] = blank[input2,input1] = -1
    blank[input1,output] = blank[input2,output] = 2
    blank[output,input1] = blank[output,input2] = 2
    return blank
def h_AND(size,input1,input2,output):
    blank = np.zeros(size)
    blank[input1]=blank[input2]=1
    blank[output]=-2
    return blank
#Full adder:
def J_FA(size, in1, in2, Cin, Cout, S):
    blank = np.zeros((size,size))
    blank[in1,in2]=blank[in2,in1]=blank[in1,Cin]=blank[Cin,in1]=blank[in2,Cin]=blank[Cin,in2]=-1
    blank[Cout,in1]=blank[in1,Cout]=blank[Cout,in2]=blank[in2,Cout]=blank[Cin,Cout]=blank[Cout,Cin]=2
    blank[S,in1]=blank[in1,S]=blank[S,in2]=blank[in2,S]=blank[S,Cin]=blank[Cin,S]=1
    blank[Cout,S]=blank[S,Cout]=-2
    return blank
def h_FA(size, in1, in2, Cin, Cout, S):
    blank = np.zeros(size)
    return blank

J_and = J_AND(3,0,1,2)
h_and = h_AND(3,0,1,2)
J_copy = J_COPY(2,0,1)
h_copy = h_COPY(2,0,1)
J_fa = J_FA(5,0,1,2,4,3)  #SUM AND THEN CARRY OUT!!
h_fa = h_FA(5,0,1,2,4,3)

"""
Created 10/23/24

Function: J_mult
    Inputs: 
        - N (NxN multiplier)
        - k (k is max nearest neighbors in copy hierarchy)
    Outputs: 
        - J weight matrix, NxN numpy matrix
        - h bias matrix, Nx1 matrix
        - size, how many total PBits
        - OUT_indices, array of output bit indices, in order of increasing bit significance
        - Clamp0_indices, the indices that are the carry in of a Full adder that was originally a Half adder


Details:
- Least significant bit of any PBit array G is G[0], 2N input PBits in "In", 2N output PBits in "Out"
- Indexes inputs A[0] -> A[N] = In[0] -> In[N-1]
- Indexes inputs B[0] -> B[N] = In[N] -> In[2N-1]
- Indexes partial products A[0]&B[0] = PBit[2N*G] = C[0], 
                           A[1]&B[0] = PBit[2N*G+1],
                           A[N]&B[N] = PBit[2N*G+N**2]
- Index offset ("base") for first adder = 2N*G+N**2 
- Indexing for each element of each full adder:
    - IN1 = base+1, IN2 = base+2, CarrIN = base+3, SUM = base+4, CarrOUT = base+5
- Adders indexed as described in "PBit" notebook in Onenote
    - Two sections: right half and left half.
        ~ right half: Ascending upper half including diagonal of a N-1 x N-1 matrix of adders
        ~ left half: Descending lower half including diagonal of a N-1 x N-1 matrix of adders

Copy hierarchy:
- 

Notes:
- h for COPY and FA is null, so we only have to worry about h for AND gates.

"""
def J_mult(N,k):
    #============================================================================================
    #Handle the copy gate hierarchy that connects common input bits. 
    #-------------------------------------------------------------------------
    #Number of layers, including top and bottom:
    layers = int(np.ceil(np.emath.logn(int(k-1), N))+1)
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    #Total number of Pbits in copy hierarchy = T
    T = 0    
    A = N
    Leftover = 0
    for i in range(layers):
        if (A==0):
            T += 2*N
        else:
            T += 2*N*A
            Leftover += int((A % (k-1)))
            A = int(np.floor(A/(k-1)) + np.floor(Leftover/(k-1)))
            if ((Leftover>0) and ((i+2)==(layers-1)) and ((A+Leftover)>(k-1))):
                A+=1
                Leftover=0
            else:
                Leftover -= (k-1)*np.floor(Leftover/(k-1))
            # T += 2*N*A
            # Leftover += (A % (k-1))
            # A = int(np.floor(A/(k-1)) + np.floor(Leftover/(k-1))) #Don't need another PBit unless 4 leftovers
            # Leftover -= (k-1)*np.floor(Leftover/(k-1))
    #-------------------------------------------------------------------------

     #Total number of PBits:
    size = int(T + N**2 + 2*5*(((N-1)**2 + N-1)/2))
    print("There are ",size," PBits in the circuit")

    J_blank = np.zeros((size,size))
    h_blank = np.zeros(size)
    
    #Now, Do the numbering and Copying:
    # Bottom row of AND Hierarchy:
    Bottom = [] #This is where each Input bit attaches into the AND gates in multiplier
    unpaired = []
    for i in range(2*N):
        unpaired.append([])
        Bottom.append([])
        for j in range(N):
            unpaired[i].append(T-(i*N+j+1))
            Bottom[i].append((i*N+j+1)+(T-2*N**2)-1)
    #print(unpaired)

    #Rest of AND Hierarchy:
    Offset = 2*N**2
    counter = 1
    flag = 1    #unpaired is nonzero
    #print(unpaired)
    while(flag == 1):
        for i in range(2*N):
            pairs = int(np.floor(len(unpaired[i])/(k-1)))
            if(pairs>0):
                new_list = []
                for j in range(pairs):
                    for l in range(k-1):
                        J_blank[unpaired[i][j*(k-1)+l],T-(Offset+counter)] += J_copy[0,1]
                        J_blank[T-(Offset+counter),unpaired[i][j*(k-1)+l]] += J_copy[1,0]
                    new_list.append(T-(Offset+counter))
                    counter += 1
                del unpaired[i][0:(pairs*(k-1))]
                for j in range(len(new_list)):
                    unpaired[i].append(new_list[j])
            else:
                new = 0
                if (len(unpaired[i])>1):
                    for j in range(len(unpaired[i])):
                        J_blank[unpaired[i][j],T-(Offset+counter)] += J_copy[0,1]
                        J_blank[T-(Offset+counter),unpaired[i][j]] += J_copy[1,0]
                    new = T-(Offset+counter)
                    counter += 1
                    del unpaired[i][0:len(unpaired[i])]
                    unpaired[i].append(new)
                else:
                    flag=0
    #==================================================================================================
    print(Bottom)
    #Keep track of AND gate outputs:
    AND_outs = np.zeros((N,N)) #Indexed by i,j
    
    #Keep track of output indices:
    OUT_indices = np.zeros(2*N)
    OUT_indices[0] = T
    
    #Keep track of bits that need to remain 0 (Full adder CAR_IN = 0 to emulate half adder)
    Clamp0_indices = np.zeros(N) #N-1 in right half, 1 in left half
    #DO NOT UPDATE THESE PBITS
    
    base = 0 #Will be used to calculate the base address for each gate
    #AND gates: ("Partial products")
    for j in range(N): #B Pbits
        for i in range(N): # A Pbits
            AND_outADD = j*N+i + T
            AND_outs[j,i] = AND_outADD
            #J:
            J_blank[Bottom[i][j],Bottom[j+N][i]]+=J_and[0,1]
            J_blank[Bottom[j+N][i],Bottom[i][j]]+=J_and[1,0]
            J_blank[Bottom[i][j],AND_outADD]+=J_and[0,2]
            J_blank[AND_outADD,Bottom[i][j]]+=J_and[0,2]
            J_blank[Bottom[j+N][i],AND_outADD]+=J_and[0,2]
            J_blank[AND_outADD,Bottom[j+N][i]]+=J_and[0,2]
            #h:
            h_blank[Bottom[i][j]]+=h_and[0]
            h_blank[Bottom[j+N][i]]+=h_and[1]
            h_blank[AND_outADD]+=h_and[2]
#             print("And gate:\t",Bottom[i][j],"\t",Bottom[j+N][i],"\t",AND_outADD)
    #Adders in right half: 
        #j starts at 1, upper half of square matrix so i goes from 0 -> j
    for j in range(1,N): 
        for i in range(j):
            base = int(T + N**2 - 1 + 5*((j**2+j)/2) - 5*(j-i))
            #Adder, iterates through the 5x5 adder hamiltonian:
            for k in range(5):
                for l in range(5):
                    if (k!=l):  #No self interaction
                        J_blank[base+1+k,base+1+l]+=J_fa[k,l]  #base+0 is the last PBit in the previous adder
#                 print("Full Adder address: ",base+1+k)
            #Copy gate between adders from right to left:
            if (j<N-1):  #we include carries TO the N-1 row here. For carries from the N-1 to the Nth row, see the left half below
                J_blank[base+5,base+5*j+3] += J_copy[0,1] #+5*i takes care of adders above left adder, 
                J_blank[base+5*j+3,base+5] += J_copy[1,0] #+5*(j-i-1) is for adders below right adder
#                 print("copy from ",base+5," to ",base+5*j+3)
            #Copy gate between this adder and the one above it:
            if (i==0): #This is the first row, two partial products per adder, no carry from above
                #No carry from above
                #Copies between two partial products and inputs
                J_blank[base+1,int(AND_outs[i,j])] += J_copy[0,1]
                J_blank[int(AND_outs[i,j]),base+1] += J_copy[1,0]
                J_blank[base+2,int(AND_outs[i+1,j-1])] += J_copy[0,1]
                J_blank[int(AND_outs[i+1,j-1]),base+2] += J_copy[1,0]
#                 print("right, i=0, adder_address=",base+1,", AND_address=",int(AND_outs[i,j]))
#                 print("right, i=0, adder_address=",base+2,", AND_address=",int(AND_outs[i+1,j-1]))
            else:
                #AND output indexed by inputs B[i+1] and A[j-i-1]
                J_blank[base+2,int(AND_outs[i+1,j-i-1])] += J_copy[0,1]
                J_blank[int(AND_outs[i+1,j-i-1]),base+2] += J_copy[1,0]
#                 print("copy from ",base+2," to ",int(AND_outs[i+1,j-i-1]))
                #Carry from above:
                J_blank[base+1,base-1] += J_copy[0,1]
                J_blank[base-1,base+1] += J_copy[1,0]
#                 print("copy from ",base-1," to ",base+1)
            if (j == i+1): #HALF ADDER. Keep track of output indices, and CAR_IN -> 0 clamp bits
                OUT_indices[j]=base+4
                Clamp0_indices[j-1] = base+3
    #Adders in left half:
        #Descending matrix, start
    base = int(T + N**2 - 1 + 5*((N**2-N)/2)) #Note: 5*((N**2-N)/2) = 5*(((N-1)**2+(N-1))/2)
    for j in range(1,N): #indexing j (columns) from 1 to N-1
        for i in range(N-j): #rows: rightmost column has adders top to bottom at i=0,1,...,N-2. Each column going left decreases number of rows by 1
            #Adder, iterates through the 5x5 adder hamiltonian:
            for k in range(5):
                for l in range(5):
                    if (k!=l):  #No self interaction
                        J_blank[base+1+k,base+1+l]+=J_fa[k,l]  #base+0 is the last PBit in the previous adder
#                 print("Full Adder address: ",base+1+k)
                        #J_blank[base+1+l,base+1+k]+=J_fa[l,k]
            #Copy gates between adders:
            if (j==1):     #Copy gate between adders from left to right for rightmost column on left half of adders:
                J_blank[base+3,base-5*(N-1)+5] += J_copy[0,1] 
                J_blank[base-5*(N-1)+5,base+3] += J_copy[1,0] 
#                 print("copy from ",base+3," to ",base-5*(N-1)+5)
                if (i==0): #clamp second input to 0, half adder
                    Clamp0_indices[N-1] = base+1
                    if (N==2):
                        OUT_indices[2*N-1]=base+5
                if (i==N-2): #This is a bottom adder, output is output bits
                    OUT_indices[N-1+j]=base+4
                if (i!=0):
                    J_blank[base+1,base-1] += J_copy[0,1] 
                    J_blank[base-1,base+1] += J_copy[1,0]
#                     print("copy from ",base-1," to ",base+1)
            elif (j<=N-1):
                if (i==0): #from northeast to southwest
                    J_blank[base+1,base-5*(N-j+1)+5] += J_copy[0,1] 
                    J_blank[base-5*(N-j+1)+5,base+1] += J_copy[1,0] 
#                     print("copy from ",base+1," to ",base-5*(N-j+1)+5)
                    if (j==N-1):  #This is the very last adder, carry is an output
                        OUT_indices[2*N-1]=base+5
                else:      #Need copy gate from top to bottom
                    J_blank[base+1,base-1] += J_copy[0,1] 
                    J_blank[base-1,base+1] += J_copy[1,0]
#                     print("copy from ",base-1," to ",base+1)
                if (i==N-j-1): #This is a bottom adder, output is output bits
                    OUT_indices[N-1+j]=base+4
                #Copy gate from right to left for column j!=1:
                J_blank[base+3,base-5*(N-j)+5] += J_copy[0,1] 
                J_blank[base-5*(N-j)+5,base+3] += J_copy[1,0]
#                 print("copy from ",base+3," to ",base-5*(N-j)+5)
            #Copy gates from AND gates to adders:
            J_blank[base+2,int(AND_outs[i+j,N-i-1])] += J_copy[0,1] 
            J_blank[int(AND_outs[i+j,N-i-1]),base+2] += J_copy[1,0]
#             print("copy from ",base+2," to ",int(AND_outs[i+j,N-i-1]))
            #After all rules are applied for this base, increment base by 5 for next adder
            base += 5
#     print(AND_outs)
#     print(AND_outs[2,0])
    print("Output indices are at ",OUT_indices[:])
    return J_blank, h_blank, size, OUT_indices, Clamp0_indices

def I_table(N,k):
    #Weight and bias:
    J, h, size, outs, zeros = J_mult(N,k)
    ones = np.ones((size,), dtype=int)
    h = h-np.matmul(J,ones)
    J = 2*J
    
    # Build the three dimensional list. Keep track of nonzero indices
    I_lookup = []
    Nonzero_indices = []
    for x in range(0,size):
        nonzero = np.count_nonzero(J[x])
        I_lookup.append(np.zeros((2**nonzero,nonzero+1)))
        Nonzero_indices.append(np.zeros(nonzero))
        #----------------------------------------------------------------
        #Add nonzero J elements to array "temporary":
        temporary = np.zeros(nonzero)
        count = 0
        for y in range(size):
            if (J[x][y]!=0):
                Nonzero_indices[x][count] = y
                temporary[count] = J[x][y]
                count+=1
        #----------------------------------------------------------------
        #Create array of all possible combinations nearest neighbors (nonzero J)
        for y in range(2**nonzero):
            for z in range(nonzero):
                I_lookup[x][y][z] = int(bool(y & int(2**z)))
            I = np.sum(I_lookup[x][y][0:nonzero]*temporary) + h[x]
            I_lookup[x][y][-1] = I
    return I_lookup, Nonzero_indices, size, outs, zeros