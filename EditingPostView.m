//
//  EditingPostView.m
//  Instatype
//
//  Created by Uchida Tatsuya on 10/13/13.
//  Copyright (c) 2013 Uchida Tatsuya. All rights reserved.
//

#import "EditingPostView.h"

@implementation EditingPostView


- (id)init
{
    self = [super init];
    if (self) {
        _scaleBefore = 1;
        _activeTextViewNum = -1;
        
        //Array of textView
        _textViewArray = [NSMutableArray array];
        
        _brushViewArray = [NSMutableArray array];
        [_brushViewArray addObject:[[UIImage alloc] init]];
        
        _selectedTool = @"type";
    }
    return self;
}



- (void)drawPartsWithView:(UIView*)view
{
    //setting of ImageView
    _imageView = [[UIImageView alloc] init];
    [_imageView setBackgroundColor:[UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.0]];
    [_imageView setFrame:CGRectMake(6, 0, 308, 308)];
    [_imageView setUserInteractionEnabled:YES];
    [_imageView.layer setMasksToBounds:YES];
    [view addSubview:_imageView];
    
    _brushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 308, 308)];
    [_brushImageView setUserInteractionEnabled:YES];
    [_brushImageView.layer setMasksToBounds:YES];
    [_imageView addSubview:_brushImageView];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *editButtonImage = [UIImage imageNamed:@"boundingbox_icon_edit.png"];
    [_editButton setImage:editButtonImage forState:UIControlStateNormal];
    [_editButton addTarget:self action:@selector(tapEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [_editButton setHidden:YES];
    [_imageView addSubview:_editButton];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *deleteButtonImage = [UIImage imageNamed:@"boundingbox_icon_close.png"];
    [_deleteButton setImage:deleteButtonImage forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(tapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton setHidden:YES];
    [_imageView addSubview:_deleteButton];
    
    //Draw toolView on the Keyboard
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect textToolViewRect = CGRectMake(0, screen.size.height-32, screen.size.width, 32);
    _textToolView = [[UIView alloc] initWithFrame:textToolViewRect];
    [_textToolView setBackgroundColor:[UIColor clearColor]];
    
    _textEditDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *textEditDoneImage = [UIImage imageNamed:@"keyboard_icon_check.png"];
    [_textEditDoneButton setImage:textEditDoneImage forState:UIControlStateNormal];
    [_textEditDoneButton setFrame:CGRectMake(screen.size.width - textEditDoneImage.size.width, 0, textEditDoneImage.size.width, textEditDoneImage.size.height)];
    [_textEditDoneButton addTarget:self action:@selector(doneTextEdit:) forControlEvents:UIControlEventTouchUpInside];
    [_textToolView addSubview:_textEditDoneButton];
    
    UIImage *undoImage = [UIImage imageNamed:@"tool_button_undo.png"];
    undoImage = [undoImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _undoButton = [[UIButton alloc] initWithFrame:CGRectMake(273, 269, 33, 33)];
    [_undoButton setImage:undoImage forState:UIControlStateNormal];
    [_undoButton setTintColor:[UIColor blackColor]];
    [_undoButton addTarget:self action:@selector(tapUndoButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_undoButton];
    [_undoButton setHidden:YES];
    
}




-(void)addTextView{
    //setting of textView
    UITextView *textView = [[UITextView alloc] init];
    
    [textView setTextAlignment:NSTextAlignmentCenter];
    [textView setFont:[UIFont fontWithName:@"Amatic-Bold" size:30]];
    [textView setTextColor:[UIColor blackColor]];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setEditable:YES];
    [textView setDelegate:self];
    [textView setScrollEnabled:NO];
    [textView.layer setMasksToBounds:NO];
    [textView becomeFirstResponder];
    [textView setSpellCheckingType:UITextSpellCheckingTypeNo];
    [textView setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [textView setInputAccessoryView:_textToolView];
    CGRect textViewRect = [@"sample" boundingRectWithSize:_imageView.frame.size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:textView.font}
                                             context:nil];
    CGSize size = textViewRect.size;
    [textView setFrame:CGRectMake(_imageView.frame.size.width/2-size.width/2-15, _imageView.frame.size.height/2-size.height/2-10, size.width+30, size.height+20)];
    [_imageView addSubview:textView];
    
    
    //Add TextView to Array
    _activeTextViewNum = [_textViewArray count];
    [_textViewArray addObject:textView];
    
    
    //edit and delete button have to show on front
    [_imageView bringSubviewToFront:_editButton];
    [_imageView bringSubviewToFront:_deleteButton];
}





//Delegate of textView
//make 1 px line around textview
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //Clear all boarders and draw a boarder of editing TextView
    for (int i = 0; i < [_textViewArray count]; i++) {
        [[[_textViewArray objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
    }
    [textView.layer setBorderWidth:1];
    [textView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    
    //Hide buttons
    [_editButton setHidden:YES];
    [_deleteButton setHidden:YES];
    
    return YES;
}

//Adjust size of TextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    //@" ":space is necessary to adjust a size when return the text
    NSString *textViewString = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByAppendingString:@" "];
    [textView setFrame:[self adjustBorder:textView withString:textViewString]];
    [self adjustButtonPosition:textView.frame];
    
    [textView.layer setBorderWidth:1];
    [textView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    
    return YES;
}




-(BOOL)textViewShouldEndEditing:(UITextView*)textView
{
    
    [textView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_editButton setHidden:NO];
    [_deleteButton setHidden:NO];
    
    [textView setEditable:NO];
    
    return YES;
}



//GestureRecognizer
//Close keyboard and focus out
- (void)tapTextView:(UITapGestureRecognizer *)sender
{
 
    if ([_selectedTool isEqualToString:@"type"]) {
        
        BOOL touchAnyTextView = NO;
        
        for (int i = 0; i < [_textViewArray count]; i++) {
            
            UITextView *textView = [_textViewArray objectAtIndex:i];
            
            //When tap a TextView or not
            if (CGRectContainsPoint(textView.frame, [sender locationInView:_imageView]))
            {
                //Every TextView borders turn clear
                for (int j = 0; j < [_textViewArray count]; j++) {
                    [[[_textViewArray objectAtIndex:j] layer] setBorderColor:[[UIColor clearColor] CGColor]];
                }
                
                //Top TextView's border turns white
                [textView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
                
                //show edit button and delete button
                [_editButton setHidden:NO];
                [_deleteButton setHidden:NO];
                [self adjustButtonPosition:textView.frame];
                
                
                touchAnyTextView = YES;
                _activeTextViewNum = i;
                
            } else {
                
                [textView resignFirstResponder];
            }
        }
        
        if (!touchAnyTextView) {
            for (int i = 0; i<[_textViewArray count]; i++) {
                [[[_textViewArray objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
            }
            [_editButton setHidden:YES];
            [_deleteButton setHidden:YES];
            if (_activeTextViewNum != -1) {
                _activeTextViewNum = -1;
            } else {
                [self addTextView];
            }
        } else {
            touchAnyTextView = NO;
        }
        
        
    }
}



//move text
- (void)panTextView:(UIPanGestureRecognizer *)sender
{
    
    if ([_selectedTool isEqualToString:@"type"]) {
    
        for (int i = 0; i < [_textViewArray count]; i++) {
            UITextView *textView = [_textViewArray objectAtIndex:i];
            if (CGRectContainsPoint(textView.frame, [sender locationInView:_imageView])&&sender.state == UIGestureRecognizerStateBegan) {
                _activeTextViewNum=i;
            }
            
            [textView.layer setBorderColor:[[UIColor clearColor] CGColor]];
        }
        
        if (_activeTextViewNum >= 0)
        {
            UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
            CGPoint translation = [sender translationInView:_imageView];
            
            CGRect newFrame = CGRectMake(textView.frame.origin.x+translation.x, textView.frame.origin.y+translation.y, textView.frame.size.width, textView.frame.size.height);
            [textView setFrame:newFrame];
            [sender setTranslation:CGPointZero inView:_imageView];
            
            [self adjustButtonPosition:textView.frame];
        }
        
        if (sender.state == UIGestureRecognizerStateBegan) {
            
            for (int i = 0; i<[_textViewArray count]; i++) {
                [[[_textViewArray objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
            }
            [_editButton setHidden:YES];
            [_deleteButton setHidden:YES];
            
        }
        
        if (sender.state == UIGestureRecognizerStateEnded && _activeTextViewNum >= 0) {
            [[[_textViewArray objectAtIndex:_activeTextViewNum] layer] setBorderColor:[[UIColor whiteColor] CGColor]];
            [_editButton setHidden:NO];
            [_deleteButton setHidden:NO];
        }
         
        
    } else if([_selectedTool isEqualToString:@"brush"]) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            _touchPoint = [sender locationInView:_brushImageView];
            [_undoButton setHidden:YES];
        }
        
        // 現在のタッチ座標をローカル変数currentPointに保持
        CGPoint currentPoint = [sender locationInView:_brushImageView];
        
        // 描画領域をcanvasの大きさで生成
        UIGraphicsBeginImageContextWithOptions(_brushImageView.frame.size, NO, 2);
        
        // canvasにセットされている画像（UIImage）を描画
        [_brushImageView.image drawInRect:
         CGRectMake(0, 0, _brushImageView.frame.size.width, _brushImageView.frame.size.height)];
        
        // 線の角を丸くする
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        
        // 線の太さを指定
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6.0);
        
        // 線の色を指定（RGB）
        int numComponents = CGColorGetNumberOfComponents(_brushColor.CGColor);
        
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(_brushColor.CGColor);
            CGFloat red = components[0];
            CGFloat green = components[1];
            CGFloat blue = components[2];
            
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        }
        
        
        // 線の描画開始座標をセット
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _touchPoint.x, _touchPoint.y);
        
        // 線の描画終了座標をセット
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        
        // 描画の開始～終了座標まで線を引く
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        // 描画領域を画像（UIImage）としてcanvasにセット
        _brushImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 描画領域のクリア
        UIGraphicsEndImageContext();
        
        // 現在のタッチ座標を次の開始座標にセット
        _touchPoint = currentPoint;
        
        if (sender.state == UIGestureRecognizerStateEnded) {
            [_brushViewArray addObject:_brushImageView.image];
            [_undoButton setHidden:NO];
        }
    }
    
}


//zoom text
- (void)pinchTextView:(UIPinchGestureRecognizer *)sender
{
    
    if ([_selectedTool isEqualToString:@"type"]) {
        
        for (int i = 0; i < [_textViewArray count]; i++) {
            UITextView *textView = [_textViewArray objectAtIndex:i];
            if (CGRectContainsPoint(textView.frame, [sender locationInView:_imageView])&&sender.state == UIGestureRecognizerStateBegan&&_activeTextViewNum<0) {
                _activeTextViewNum=i;
            }
        }
        
        if (_activeTextViewNum >= 0) {
            UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
            float scale = [sender scale];
            
            float fontSize = textView.font.pointSize+(scale-_scaleBefore)*50;
            
            [textView setFont:[UIFont fontWithName:textView.font.fontName size:fontSize]];
            _scaleBefore = scale;
            
            [textView setFrame:[self adjustBorder:textView withString:textView.text]];
            [self adjustButtonPosition:textView.frame];
            
            [textView.layer setBorderColor:[[UIColor clearColor] CGColor]];
            
            [_editButton setHidden:YES];
            [_deleteButton setHidden:YES];
            
        }
        
        if (sender.state==UIGestureRecognizerStateEnded && _activeTextViewNum >= 0) {
            _scaleBefore=1;
            UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
            [textView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            
            [_editButton setHidden:NO];
            [_deleteButton setHidden:NO];
        }
        
    }
}




- (void)fontChange
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        [textView setFrame:[self adjustBorder:textView withString:textView.text]];
        [self adjustButtonPosition:textView.frame];
    }
}


- (void)hideAllFunction
{
    [_editButton setHidden:YES];
    [_deleteButton setHidden:YES];
    [_addtypeButton setHidden:YES];
    
    
    for (int i = 0; i<[_textViewArray count]; i++) {
        [[[_textViewArray objectAtIndex:i] layer] setBorderColor:[[UIColor clearColor] CGColor]];
        [[_textViewArray objectAtIndex:i] resignFirstResponder];
    }
}




//change text color
- (void)changeTextColor:(UIButton*)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        
        if ([textView textColor]==[UIColor blackColor]) {
            [textView setTextColor:[UIColor whiteColor]];
        } else {
            [textView setTextColor:[UIColor blackColor]];
            
        }
    }
}

- (void)changeTextAlignLeft:(UIButton*)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        
        [textView setTextAlignment:NSTextAlignmentLeft];
    }
}

- (void)changeTextAlignCenter:(UIButton*)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        
        [textView setTextAlignment:NSTextAlignmentCenter];
    }
}

- (void)changeTextAlignRight:(UIButton*)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        
        [textView setTextAlignment:NSTextAlignmentRight];
    }
}

- (void)doneTextEdit:(UIButton*)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        
        [textView resignFirstResponder];
    }
}



//Adjust Border of TexView and Buttons
- (CGRect)adjustBorder:(UITextView*)textView withString:(NSString*)string
{
    CGRect textViewRect = [string boundingRectWithSize:CGSizeMake(320, 320)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:textView.font}
                                                  context:nil];
    CGSize size = textViewRect.size;
    
    CGRect adjustedRect = CGRectMake(textView.frame.origin.x+(textView.frame.size.width-size.width-30)/2, textView.frame.origin.y+(textView.frame.size.height-size.height-20)/2, size.width+30, size.height+20);
    
    return adjustedRect;
}

- (void)adjustButtonPosition:(CGRect)rect{
    [_editButton setFrame:CGRectMake(rect.origin.x-17, rect.origin.y-17, 33, 33)];
    [_deleteButton setFrame:CGRectMake(rect.origin.x+rect.size.width-17, rect.origin.y-17, 33, 33)];
}



- (void)tapEditButton:(UIButton*)sender{
    UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
    [textView setEditable:YES];
    [textView becomeFirstResponder];
}

- (void)tapDeleteButton:(UIButton *)sender
{
    if (_activeTextViewNum>=0) {
        UITextView *textView = [_textViewArray objectAtIndex:_activeTextViewNum];
        [textView removeFromSuperview];
        [_textViewArray removeObjectAtIndex:_activeTextViewNum];
        _activeTextViewNum = -1;
        [_editButton setHidden:YES];
        [_deleteButton setHidden:YES];
        
    }
}

-(void)tapAddtypeButton:(UIButton*)sender
{
    [self addTextView];
}


-(void)tapUndoButton:(UIButton*)sender
{
    //first object is clear image. so you dont delete it
    if ([_brushViewArray count]>1) {
        [_brushViewArray removeLastObject];
    }
    if ([_brushViewArray count]>0) {
        [_brushImageView setImage:[_brushViewArray objectAtIndex:[_brushViewArray count]-1]];
    }
}

@end
