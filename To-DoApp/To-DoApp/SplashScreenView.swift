import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        }else{
            VStack{
                VStack{
                    Image("Tick")
                        .frame(width: 350, height: 60)
                        .scaledToFit()
                        .foregroundColor(.red)
                        .opacity(0.2)
                        .overlay(
                            Image("Tick")
                            .resizable()
                            .frame(width: 180, height: 180)
                            .scaledToFit()
                            .foregroundColor(.red)
                            .padding(.top, -200.0)
                            .padding(.leading, 25)
                        )
                        

                        .overlay(
                            Text("TO-DO LIST")
                                .font(.headline)
                                .fontWeight(.heavy)
                        )
                       
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 2.0)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                    
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
