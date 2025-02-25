package com.study.pet.JinMail;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
 
@Getter
@Setter
@NoArgsConstructor
public class MailDto {
    private String address;
    private String title;
    private String content;
    private String FromAdress;
    private String code;
    private String mail;
}
