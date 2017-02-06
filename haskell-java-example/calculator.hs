import Foreign.Java
import Data.Maybe

import Foreign.Java.Bindings.Support


main :: IO ()
main = runJavaGui $ do
    
    (Just jFrameClass)  <- getClass "javax.swing.JFrame"
    (Just jButtonClass) <- getClass "javax.swing.JButton"
    (Just jGridLayoutClass) <- getClass "java.awt.GridLayout"

    setVisible   <- jFrameClass `bindMethod` "setVisible" ::= boolean --> void
    addComponent <- jFrameClass `bindMethod` "add" ::= object "java.awt.Component"
                                                   --> object "java.awt.Component"
    setLocation  <- jFrameClass `bindMethod` "setLocationRelativeTo" ::= object "java.awt.Component"
                                                                     --> void
    setSize'     <- jFrameClass `bindMethod` "setSize" ::= int --> int --> void
    let setSize obj (a, b) = setSize' obj a b
    setLayout    <- jFrameClass `bindMethod` "setLayout" ::= object "java.awt.LayoutManager"
                                                         --> void

    addActionListener <- jButtonClass
        `bindMethod` "addActionListener" ::= object "java.awt.event.ActionListener" --> void

    (Just jButtonConstr)     <- getConstructor jButtonClass $ string
    (Just jGridLayoutConstr) <- getConstructor jGridLayoutClass $ int --> int
    
    (Just jFrame) <- newObject jFrameClass
    
    newObjectFrom jGridLayoutConstr 4 4 >>= setLayout jFrame

    buttons <- mapM (newObjectFrom jButtonConstr)
                    [ "1", "2", "3", "*"
                    , "4", "5", "6", "-"
                    , "7", "8", "9", "·"
                    , "C", "0", "=", "÷" ]
    
    mapM_ (addComponent jFrame) buttons

    let action = do
            io $ putStrLn "Let's have some fun!"

    listener <- sushimaki "java.awt.event.ActionListener" action

    mapM_ (flip addActionListener (Just listener) . fromJust) buttons

    jFrame `setSize` (400, 300)
    jFrame `setLocation` Nothing
    jFrame `setVisible` True








