//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Vasudhara Kantroo on 9/21/14.
//  Copyright (c) 2014 Vasudhara Kantroo. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    var originalPosition: CGPoint!
    var laterOrigin: CGPoint!
    var archiveOrigin: CGPoint!
    var deleteOrigin: CGPoint!
    var listOrigin: CGPoint!

    
    @IBOutlet weak var viewer: UIView!

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var later: UIImageView!
    @IBOutlet weak var archive: UIImageView!
    @IBOutlet weak var delete: UIImageView!
    @IBOutlet weak var list: UIImageView!
    
    //var isDirectionTowardsRight: Bool

    
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.alpha = 0
        rescheduleView.alpha = 0
        
        scrollView.contentSize =  CGSize(width: 320, height: 1350)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRescheduleTap(gestureRecognizer: UITapGestureRecognizer) {
        println("tapped")
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
        })
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            }) { (tapdone: Bool) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.viewer.backgroundColor = UIColor.lightGrayColor()
                self.messageView.center.x = 160
            })
        }
        
       
    }
    
    @IBAction func onListTap(sender: AnyObject) {
        
        println("tapped2")
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
        })
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.listView.alpha = 0
            }) { (tapdone: Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.viewer.backgroundColor = UIColor.lightGrayColor()
                    self.messageView.center.x = 160
                })
        }
        

    }
    
    
    @IBAction func onPan(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var translation = gestureRecognizer.translationInView(view)
        
        viewer.backgroundColor = UIColor.lightGrayColor()

        
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            originalPosition = messageView.center
            laterOrigin = later.center
            archiveOrigin = archive.center
            deleteOrigin = delete.center
            listOrigin = list.center
            
            later.alpha = 0
            archive.alpha = 0
            delete.alpha = 0
            list.alpha = 0
            
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Changed) {
            messageView.center = CGPoint(x: originalPosition.x + translation.x, y: originalPosition.y)
            later.alpha = 0.4
            archive.alpha = 0.4
            
            if(translation.x < -60 && translation.x > -260) {
                self.viewer.backgroundColor = UIColor.yellowColor()
                later.center.x = laterOrigin.x + 60 + translation.x
                self.later.alpha = 1

            } else if(translation.x < -260) {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.later.alpha = 0
                    self.list.alpha = 1
                    }, completion: { (finishedstate: Bool) -> Void in
                        self.viewer.backgroundColor = UIColor.brownColor()
                })
            } else if (translation.x > 60 && translation.x < 260) {
                self.viewer.backgroundColor = UIColor.greenColor()
                archive.center.x = archiveOrigin.x - 60 + translation.x
                self.archive.alpha = 1
                
            } else if(translation.x > 260) {
                later.alpha = 0
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.archive.alpha = 0
                    self.delete.alpha = 1
                    }, completion: { (finishedstate: Bool) -> Void in
                        self.viewer.backgroundColor = UIColor.redColor()
                })
            }
            
    
        } else if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            println(translation.x)
            
            if(translation.x < 0 && translation.x >= -60) {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.messageView.center = self.originalPosition
                })
            } else if (translation.x < -60 && translation.x > -260) {
                viewer.backgroundColor = UIColor.yellowColor()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: -160, y: self.messageView.center.y)
                    self.later.center.x = 20
                    }, completion: { (finished: Bool) -> Void in

                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleView.alpha = 1
                        })
                })
                
            } else if(translation.x < -260) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = CGPoint(x: -160, y: self.messageView.center.y)
                    self.list.center.x = 20
                    self.viewer.backgroundColor = UIColor.brownColor()
                    }, completion: { (finalState: Bool) -> Void in

                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.listView.alpha = 1
                    })
                })
            } else if(translation.x > 0 && translation.x <= 60) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center = self.originalPosition
                })
            } else if (translation.x > 60 && translation.x < 260) {
                viewer.backgroundColor = UIColor.greenColor()
                later.alpha = 0
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = 480
                    self.archive.center.x = 280
                    }, completion: { (finalState: Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.viewer.backgroundColor = UIColor.lightGrayColor()
                            self.viewer.hidden = true
                            self.feedImage.center.y = self.feedImage.center.y - 80
                        })
                })
                
            } else if(translation.x > 260) {
                    viewer.backgroundColor = UIColor.redColor()
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.messageView.center.x = 480
                        self.delete.center.x = 280
                        }, completion: { (finalState: Bool) -> Void in
                            UIView.animateWithDuration(0.2, animations: { () -> Void in
                                self.viewer.backgroundColor = UIColor.lightGrayColor()
                                self.viewer.hidden = true
                                self.feedImage.center.y = self.feedImage.center.y - 80
                            })
                    })
            }
}
}
}

        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

/*later.center = CGPoint(x: 270, y: 30)
archive.center = CGPoint(x: 20, y: 30)
list.center = CGPoint(x: 60, y: 30)
delete.center = CGPoint(x: 180, y: 30)*/